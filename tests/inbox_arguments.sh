#!/bin/bash
set -euo pipefail

repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
test_dir=$(mktemp -d)
trap 'rm -rf "$test_dir"' EXIT

# Load the launcher without running its main function or touching real profiles.
source <(sed '$d' "$repo_dir/inbox")
INBOX_CONFIG_DIR="$test_dir/profiles"
DEFAULT_CONFIG_FILE="$INBOX_CONFIG_DIR/default.conf"
INBOX_IMAGE="test/inbox:arguments"
mkdir -p "$test_dir/project"
cd "$test_dir/project"
touch glob-match.txt

# Capture exactly what the launcher would pass to Docker, including empty args.
function docker() {
    printf '%s\0' "$@" > "$test_dir/actual"
}

function check_args() {
    local agent="$1"
    local defaults="$2"
    shift 2
    local args=("$@")
    local expected=(run -it --rm
        -v "$INBOX_CONFIG_DIR/$agent:/home/inbox"
        -v "$test_dir/project:/workspace"
        -e "HOST_UID=$(id -u)"
        "$INBOX_IMAGE")
    if [[ "$defaults" == true ]]; then
        expected+=("$(get_agent_details "$agent")")
        main "$agent" ${args[@]+"${args[@]}"} > /dev/null
    else
        main "$agent" -n ${args[@]+"${args[@]}"} > /dev/null
    fi
    if [[ ${#args[@]} -gt 0 ]]; then
        expected+=("${args[@]}")
    fi
    printf '%s\0' "${expected[@]}" > "$test_dir/expected"
    if ! cmp -s "$test_dir/expected" "$test_dir/actual"; then
        echo "FAIL: argument forwarding for $agent (defaults=$defaults)" >&2
        return 1
    fi
}

for agent in antigravity claude codex gemini; do
    for defaults in true false; do
        check_args "$agent" "$defaults"
        check_args "$agent" "$defaults" 'hello world' '' '*.txt' $'line one\nline two' '"quoted"' '$(echo literal)' 'back\slash'
    done
done

echo 'PASS: argument forwarding for all agents, with and without default arguments'
