#!/bin/bash
set -euo pipefail

repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
test_dir=$(mktemp -d)
trap 'rm -rf "$test_dir"' EXIT
source <(sed '$d' "$repo_dir/inbox")
INBOX_CONFIG_DIR="$test_dir/profiles"
DEFAULT_CONFIG_FILE="$INBOX_CONFIG_DIR/default.conf"
INBOX_IMAGE="test/inbox:arguments"
mkdir -p "$test_dir/project with spaces"
cd "$test_dir/project with spaces"
touch glob-match.txt
SSH_AUTH_SOCK="$test_dir/ssh socket"
checks=0
forwarded=()

function docker() {
    printf '%s\0' "$@" > "$test_dir/actual"
    return "${docker_exit:-0}"
}

# Expected Docker arguments are specified independently of the launcher parser.
function check_run() {
    local agent="$1" profile="$2" defaults="$3" ssh="$4" socket="$5"
    shift 5
    local profile_dir="$agent"
    [[ -z "$profile" ]] || profile_dir="$agent-$profile"
    local expected=(run -it --rm)
    if [[ "${expect_sign_in_with_chatgpt:-false}" == true ]]; then
        expected+=(-p 127.0.0.1:1455:61455 -e INBOX_SIGN_IN_WITH_CHATGPT=1)
    fi
    expected+=(-v "$INBOX_CONFIG_DIR/$profile_dir:/home/inbox"
        -v "$test_dir/project with spaces:/workspace"
        -e "HOST_UID=$(id -u)")
    if [[ "$ssh" == true ]]; then
        expected+=(-v "$SSH_AUTH_SOCK:/run/ssh-agent" -e SSH_AUTH_SOCK=/run/ssh-agent)
    fi
    if [[ -n "$socket" ]]; then
        expected+=(-v "$socket:/var/run/docker.sock")
    fi
    expected+=("$INBOX_IMAGE")
    if [[ "$defaults" == true ]]; then
        case "$agent" in
            claude|antigravity) expected+=(--dangerously-skip-permissions) ;;
            codex) expected+=(--dangerously-bypass-approvals-and-sandbox) ;;
            gemini) expected+=(--yolo) ;;
        esac
    fi
    if [[ ${#forwarded[@]} -gt 0 ]]; then
        expected+=("${forwarded[@]}")
    fi
    rm -f "$test_dir/actual"
    (main "$@") > "$test_dir/output" 2>&1
    printf '%s\0' "${expected[@]}" > "$test_dir/expected"
    if ! cmp -s "$test_dir/expected" "$test_dir/actual"; then
        printf 'FAIL: Docker argv for %s\n' "$*" >&2
        exit 1
    fi
    checks=$((checks + 1))
}

function check_error() {
    local message="$1"
    shift
    rm -f "$test_dir/actual"
    local status=0
    (main "$@") > "$test_dir/error" 2>&1 || status=$?
    if [[ "$status" != 1 ]] || ! grep -q -- "$message" "$test_dir/error" || [[ -e "$test_dir/actual" ]]; then
        printf 'FAIL: expected parser error without Docker: %s\n' "$*" >&2
        cat "$test_dir/error" >&2
        exit 1
    fi
    checks=$((checks + 1))
}

for agent in antigravity claude codex gemini; do
    for defaults in true false; do
        options=()
        [[ "$defaults" == true ]] || options=(-n)
        forwarded=()
        check_run "$agent" '' "$defaults" false '' "$agent" ${options[@]+"${options[@]}"}
        check_run "$agent" '' "$defaults" false '' "$agent" ${options[@]+"${options[@]}"} --
        forwarded=('')
        check_run "$agent" '' "$defaults" false '' "$agent" ${options[@]+"${options[@]}"} -- ''
        forwarded=(--help --version 'hello world' '' '*.txt' $'line one\nline two' '"quoted"' '$(touch should-not-exist)' '`touch should-not-exist`' 'back\slash' '日本語')
        check_run "$agent" '' "$defaults" false '' "$agent" ${options[@]+"${options[@]}"} -- "${forwarded[@]}"
        forwarded=(-p work --profile native -n --no-defaults -A --ssh-agent -D /agent/socket --docker-socket /other -- - --unknown --profile=agent)
        check_run "$agent" '' "$defaults" false '' "$agent" ${options[@]+"${options[@]}"} -- "${forwarded[@]}"
        test ! -e should-not-exist
    done

    forwarded=()
    check_run "$agent" work false true "$test_dir/docker socket" "$agent" -p work -n -A -D "$test_dir/docker socket"
    check_run "$agent" work false true "$test_dir/docker socket" "$agent" --docker-socket "$test_dir/docker socket" --ssh-agent --no-defaults --profile work --
    check_run "$agent" last false true /last "$agent" -p first -D /first -A -A -n -n --profile last --docker-socket /last
    forwarded=(mcp add --profile child -- -n '')
    check_run "$agent" work false false '' "$agent" -p work -n -- "${forwarded[@]}"

    # Unsupported flags, positional/empty arguments, and implicit forwarding fail.
    for bad in --help --version --unknown prompt '' - --profile=work -pwork -nA; do
        check_error 'Agent arguments must follow --' "$agent" "$bad"
    done
    check_error 'Agent arguments must follow --' "$agent" -p work prompt -- --help
    for option in -p --profile -D --docker-socket; do
        check_error 'Missing required argument' "$agent" "$option"
        check_error 'Missing required argument' "$agent" "$option" ''
        for next in -- -n --profile -; do
            check_error 'Expected a value' "$agent" "$option" "$next"
        done
    done

    # No socket means no SSH mount; retain the existing warning behavior.
    forwarded=()
    saved_socket="$SSH_AUTH_SOCK"
    SSH_AUTH_SOCK=''
    check_run "$agent" '' true false '' "$agent" -A --
    grep -q 'SSH_AUTH_SOCK is not set' "$test_dir/output"
    SSH_AUTH_SOCK="$saved_socket"
done

# Callback forwarding is opt-in and restricted to Codex.
expect_sign_in_with_chatgpt=true
forwarded=(login)
check_run codex work false false '' codex -p work -n --sign-in-with-chatgpt
forwarded=(login)
check_run codex '' false false '' codex --sign-in-with-chatgpt
check_run codex '' false false '' codex --sign-in-with-chatgpt --
expect_sign_in_with_chatgpt=false
check_error "cannot be combined" codex --sign-in-with-chatgpt -- login
check_error "cannot be combined" codex --sign-in-with-chatgpt -- --device-auth
check_error "cannot be combined" codex --sign-in-with-chatgpt -- ""
check_error "Agent arguments must follow --" codex --auth-callback
forwarded=(--sign-in-with-chatgpt)
check_run codex '' false false '' codex -n -- --sign-in-with-chatgpt
for agent in claude gemini antigravity; do
    check_error 'only supported for codex' "$agent" --sign-in-with-chatgpt
done

# Management commands do not become agent arguments.
rm -f "$test_dir/actual"
main --help > "$test_dir/help"
main -h > "$test_dir/short-help"
cmp "$test_dir/help" "$test_dir/short-help"
grep -q 'Agent arguments require this separator' "$test_dir/help"
main version > "$test_dir/version"
grep -q 'inbox version' "$test_dir/version"
main profile --help > "$test_dir/profile-help"
test ! -e "$test_dir/actual"
checks=$((checks + 4))
check_error 'Unknown command' -- --help
check_error 'Unknown command' unknown
check_error 'Agent arguments must follow --' claude --help
check_error 'Usage:'

main profile set-default claude work > /dev/null
forwarded=()
check_run claude work true false ''
check_run claude '' true false '' claude

# Preserve Docker/agent failure status through the actual launcher process.
mkdir -p "$test_dir/bin"
cat > "$test_dir/bin/docker" <<'DOCKER'
#!/bin/sh
exit 37
DOCKER
chmod +x "$test_dir/bin/docker"
status=0
# A separate process avoids conditional-function errexit behavior masking failures.
INBOX_IMAGE="$INBOX_IMAGE" PATH="$test_dir/bin:$PATH" bash -c '
    source <(sed '\''$d'\'' "$1/inbox")
    INBOX_CONFIG_DIR="$2/profiles"
    DEFAULT_CONFIG_FILE="$INBOX_CONFIG_DIR/default.conf"
    main claude -n -- --version
' test "$repo_dir" "$test_dir" > /dev/null 2>&1 || status=$?
test "$status" = 37
checks=$((checks + 1))
printf 'PASS: %s checks (all agents, exact Docker argv, parser errors, management commands, exit status)\n' "$checks"
