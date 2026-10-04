# Contributing to InBox

Describe the user problem, give an example command, and explain how you checked the change.
Keep the launcher small. Discuss new runtime or security layers before implementing them.

## Local checks

```bash
bash -n inbox
bash tests/inbox_arguments.sh
```

The regression test uses fake Docker calls and temporary profiles. It needs no daemon, credentials, or network.
Test container changes separately with Docker. Never use personal credentials in automated tests.

## Architecture and adding an agent

There is no plugin interface. Add an agent through these files:

| File | Change |
| --- | --- |
| `boxes/<agent>/Dockerfile` | Install the CLI and tools. Keep `/workspace` and the `/home/inbox` home directory. |
| `boxes/<agent>/entrypoint.sh` | Set up the user, then run `exec gosu inbox <agent-binary> "$@"`. Keep the CI command path if supported. |
| `inbox` | Add the agent to `get_agent_details`, validation, help, and the profile-list filter. |
| `tests/inbox_arguments.sh` | Cover arguments, profile mounts, default flags, and errors. |
| `.github/workflows/build.yml` | Build and smoke-test amd64 and arm64. Publish matching tags and update release dependencies. |
| `docs/<agent>/` | Describe login, instruction files, settings, and image differences. Link common tasks instead of copying them. |

Check arguments with spaces, empty values, shell characters, and separators.
Review user-ID and socket handling for the image's distribution.
Document any defaults that affect approvals.

The launcher mounts the profile and project as writable directories and requires a terminal.
It passes `HOST_UID`, not arbitrary host variables. See the [CLI reference](./docs/cli_reference.md) for the full behavior.

Build and check an image without credentials:

```bash
docker build -t inbox-claude:contributor boxes/claude
docker run --rm inbox-claude:contributor --help
```

Check each supported architecture. CLI smoke tests do not prove browser login or host integration support.
Test authentication manually without recording secrets.
For the Codex callback relay, see [login implementation](./docs/codex/login_implementation.md).

## Documentation

Write short sentences with one point each. Aim for 10–20 words when practical.
Keep main topics to a few sentences and one command example. Put exceptions and internal details in reference pages.

Use `work` for the usual profile example. Use other names only when the task needs a separate profile.
Call a profile without a name the **unnamed profile**. Use **default** for the saved startup selection.

Preserve existing links when moving content. Keep important access warnings near the relevant commands.
Follow the repository's [documentation guidelines](./CLAUDE.md).

## Releases

Keep the version in `inbox` equal to the release tag.
The workflow publishes the script on `v*` tags after launcher tests and image jobs pass.
Describe user-visible changes and migration steps in release notes.

Daily image rebuilds can change versioned tags. They do not lock dependency versions.
See [argument migration](./docs/cli_reference.md#argument-migration) for the v0.15.0 separator change.

## Issues

Include the host OS and architecture, Docker context, InBox version, agent image, and a minimal command.
Use the [bug report template](./.github/ISSUE_TEMPLATE/bug_report.md).
Describe expected and actual behavior. Remove credentials and private project details from output.
Do not attach profile directories or login files.

For suspected vulnerabilities, use GitHub private reporting if available.
Otherwise, request a private contact without posting secrets or exploit details.
