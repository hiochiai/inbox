# Contributing to InBox

Keep the launch path small enough to read. Include the user problem, an example command, and how you checked the change. Propose new runtime/security layers before implementing them.

## Local checks

```bash
bash -n inbox
bash tests/inbox_arguments.sh
```

The regression test uses a fake Docker function and temporary profiles; it requires no daemon, credentials, or network. Test container changes separately with Docker. Never use a personal authenticated profile for automated tests.

## Architecture and adding an agent

There is no plugin interface. The small explicit integration consists of:

1. `boxes/<agent>/Dockerfile`: install the CLI and runtime tools; set `/workspace` as working directory; retain `/home/inbox` as the persistent home.
2. `boxes/<agent>/entrypoint.sh`: perform root-side setup, then `exec gosu inbox <agent-binary> "$@"`. Preserve the CI shell path if supported. Review UID and socket handling for the base distribution.
3. `inbox`: add the name/default arguments to `get_agent_details`, validation/help, and the profile-list filter. Defaults affecting approvals must be documented and reviewed.
4. `tests/inbox_arguments.sh`: add the agent to the forwarding cases. Check arguments with spaces, empty strings, metacharacters, separator conflicts, profile mounts, and default flags.
5. `.github/workflows/build.yml`: build and smoke-test both amd64/arm64, publish the matching version/agent tags, and include the build in release dependencies. Check authentication manually without recording secrets.
6. `docs/<agent>/`: document login inside a container, persistent file locations, arguments, and custom image requirements. Add links to `docs/README.md`, the README agent table, and default-flag documentation.

The launcher supplies `HOST_UID`, not arbitrary host environment variables. It mounts a profile at `/home/inbox` and the current directory at `/workspace`, both writable, and always allocates a TTY. An explicitly tagged `INBOX_IMAGE` wins over a profile Dockerfile. Test those contracts when adding an image.

Example image smoke test (no credentials):

```bash
docker build -t inbox-claude:contributor boxes/claude
docker run --rm inbox-claude:contributor --help
```

Run on each supported architecture before claiming compatibility. The existing CI runs image CLI smoke tests on both architectures; it does not prove browser login or host integration compatibility on macOS/WSL2.

## Releases

The launcher version is in `inbox`. The workflow publishes a script asset on `v*` tags after launcher tests and image jobs succeed. Maintainers should keep the tag and script version equal, and describe user-visible changes and migration requirements in release notes. Daily image rebuilds can move version/agent tags; these are not immutable dependency locks.

Version v0.15.0 introduces the breaking requirement to put all agent arguments after `--` and adds missing-option-value diagnostics. Release notes should include migration examples; v0.14.1 does not support the separator.

## Issues

Include host OS/architecture, Docker version/context, `inbox version`, agent/image tag, a minimal command, and expected versus actual behavior. Redact tokens, home paths if private, and project details. Do not attach profile directories or authentication files. For a suspected vulnerability, use GitHub's private reporting option if the repository exposes it; otherwise request a private contact without publishing exploit details or secrets.
