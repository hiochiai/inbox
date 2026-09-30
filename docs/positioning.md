## Positioning and priorities

Assessment of source version 0.14.1 and public project information, 2026-09-29. This is a maintainer decision record, not a promise of future features or star counts.

### Current product and evidence

The previous README led with a “secure, isolated sandbox wrapper,” followed by a large documentation matrix. That undersold the durable asset: a profile home independent of a disposable container and reusable across projects. It also overstated protection of writable mounts.

The code solves concrete problems: avoid host agent/Node installations, retain separate work/personal credentials and settings, reuse agent-specific toolchains, and avoid repeating Docker mount/UID/image arguments. `run_agent` mounts `~/.inbox/<agent>[-<profile>]` as the entire home, binds the current directory, chooses a profile image when a Dockerfile exists, and runs with `--rm`. Credentials persist only where the agent stores them in that mounted home. Environments are linked to profiles, not independently named first-class objects.

Strengths: a single readable Bash launcher; four explicit agent integrations; automatic profile directory creation; custom Dockerfile builds; argument arrays preserving spaces and empty values; opt-in SSH/Docker connections; no InBox service dependency. MIT licensing, release script assets, and amd64/arm64 image smoke tests already exist.

Weaknesses: the profile concept was buried; “sandbox” invites a security comparison it cannot win; manual privileged installation; duplicated agent docs and CI; upstream-login sensitivity; no profile inspection/removal UX; always-on TTY; default approval bypass; no egress restriction; no automatic workspace copy. Gemini is deprecated in the README despite an active build job. That maintenance policy needs an explicit future decision.

Trust gaps to address separately: profile names are not constrained before forming paths/image tags; `default.conf` is written as unquoted assignments then sourced; image tags can move; the updater follows main and validates syntax only. Socket group handling assumes an existing in-container group, and UID failures are ignored. These deserve focused fixes and regression tests, not stronger marketing claims.

### Positioning choice

| Candidate | Comprehension / differentiation | Decision |
| --- | --- | --- |
| Sandbox tool | Familiar, but suggests security controls absent here | Reject as headline |
| Coding Agent runtime manager | Broadly accurate; “manager” can imply lifecycle/orchestration | Use simpler local runtime wording |
| AI CLI environment manager | Descriptive but vague about the profile benefit | Secondary search vocabulary |
| Coding Agent profile manager | Distinctive, but hides containers and custom tools | Main benefit, not category |
| Local Coding Agent Runtime | Covers launch, homes, images, and project without implying a platform | Chosen subtitle |

Canonical description:

> InBox is a lightweight local runtime for coding agents, combining disposable Docker containers with persistent, reusable profiles. Keep work and personal credentials, settings, and tool environments separate through one small CLI.

Target users (three): developers separating client/work/personal agent identities; developers trying multiple agents without installing their dependencies on the host; developers needing reusable agent toolchains across projects without writing their own wrapper.

Core differentiators (a useful combination, not claims of exclusivity): named agent-scoped homes; disposable runtime with retained state; profile Dockerfiles; consistent launch and argument forwarding; composable agent environments through opt-in Docker access. The small readable implementation supports all five.

Terminology: **agent** is the upstream CLI; **profile** is its persisted home, not a provider account abstraction; **environment** is the chosen image/toolchain; **runtime** is the Docker execution setup; **host integration** means explicitly shared host capabilities. Use **sandbox** only when discussing actual boundaries or alternatives.

### Alternatives and where to compete

| Alternative | Its focus / overlap | InBox's useful focus |
| --- | --- | --- |
| [Claude Code sandbox](https://code.claude.com/docs/en/sandboxing) | Filesystem and network restrictions for Claude's Bash tool | Reusable homes and tools across different agent CLIs, not competing sandbox enforcement |
| [Gemini CLI sandbox](https://geminicli.com/docs/cli/sandbox/) | Agent-integrated sandboxing, Docker/Podman and custom images | Consistent profile naming and launching across agents; custom images alone are not unique |
| [Docker Sandboxes](https://docs.docker.com/ai/sandboxes/security/) | MicroVM boundary, private Docker daemon, explicit workspace sharing including clone mode | A small Docker-based profile wrapper; do not claim comparable security or exclusive clone capability |
| [Dev Containers](https://github.com/devcontainers/spec) | Reusable development environment configuration for tools/editors | Personal agent homes reused across projects with less configuration; do not reimplement the spec |
| [Plain docker run](https://docs.docker.com/engine/containers/run/) | Full runtime flexibility, explicit mounts/images | Avoid maintaining repeated launch conventions and home/image naming yourself |
| [Lightweight agentbox wrapper](https://github.com/fletchgqc/agentbox) | Similar containerized agents, Docker/Podman support | Keep the named identity workflow obvious; containerization and small wrappers are not unique |

These are scope comparisons based on the linked project documentation, not rankings or exhaustive compatibility tests. InBox's advantage is packaging common needs with a simple CLI. Other wrappers also persist homes and customize tools. There is no evidence of an exclusive moat. Do not compete on strongest isolation, agent orchestration, editor integration, or cloud infrastructure.

### Agent-to-agent handoff as a core use case

With DooD enabled, a Claude session can start a sibling Codex container, select a dedicated profile/tool image, and consume non-interactive output. This makes “Claude implements, Codex reviews” a concrete reason to reuse InBox images beyond manual agent switching. It belongs among the core differentiators as **composable agent environments**, alongside profiles—not as a claim of built-in orchestration.

Docker supplies the underlying container composition; InBox supplies agent images, reusable homes, and the socket opt-in. Other Docker wrappers can do this too. Current setup requires explicit daemon-host mount paths, pre-authenticated child profiles, and agent-native headless commands; the launcher itself is not installed in the images and always requests a TTY. A [tested runtime recipe](../examples/agent-handoff/README.md) records the smoke-test scope and remaining authenticated/platform checks. No shared conversation, scheduler, or automatic handoff feature exists.

A future small handoff helper could reduce path/TTY friction if this recipe attracts use. Keep its scope to explicit image, profile, project and command selection; do not introduce an orchestration platform. Socket-enabled parents have broad Docker authority, so profile separation here is operational organization, not mutual distrust isolation.

### Naming

Keep **InBox** and add **Local Coding Agent Runtime**. The short “box” metaphor helps recall but “inbox” strongly suggests email. Search cannot be won by capitalization alone.

| Option | Assessment |
| --- | --- |
| InBox alone | Minimal migration cost; weak category recognition |
| InBox — Local Coding Agent Runtime | Best near-term clarity with unchanged command, URLs, and profile paths |
| inbox-ai | Still email-like; an [existing email AI repository](https://github.com/sayandedotcom/inbox-ai) uses it |
| agentbox | Clear category metaphor, but [multiple](https://github.com/fletchgqc/agentbox) [existing projects](https://github.com/rlaope/agentbox) already use it |
| A new coined name | Could improve searchability, but requires availability research and migration for an unproven benefit |

This checks visible project collisions, not trademark clearance. No trademark registry investigation or legal availability conclusion was made. Reconsider renaming only with measured search confusion and a distinctly available candidate.

### Feature priorities

Proposals below are not implemented. Maintenance includes upstream CLI churn and platform testing.

| Feature | Impact | Complexity | Why / maintenance cost |
| --- | --- | --- | --- |
| **1. Profile inspect + validated profile/default configuration** | High | Medium | Makes the main concept visible; report paths, mounts, image and flags without secrets; constrain names and replace shell-sourced configuration with data parsing. Low ongoing cost after migration tests |
| **2. Release-aligned updates and checksums** | High | Medium | Reduce installation/update surprises; validate downloads and tag/version agreement, document mutable image tags. Moderate release upkeep; checksums alone are not signatures |
| **3. OpenCode integration after a compatibility spike** | High | Medium | Tests whether the common UX extends to another audience; verify home/auth paths, licensing, images and both architectures. Each agent adds ongoing upstream/auth maintenance |
| Profile clone/delete | Medium | Medium | Useful once profiles accumulate; clone configuration without credentials by default, preview deletion scope, avoid accidental identity copying. Migration/secret semantics matter |
| Disposable workspace option | High | Medium | Reduce accidental source-tree edits; prefer an independent clone when protecting Git metadata. Define dirty/untracked files, submodules, cleanup and how changes return. Worktrees share metadata |
| Doctor / preflight | Medium | Low | Detect daemon, image, TTY, path and permission issues with actionable diagnostics; add host-platform checks incrementally |
| Hardening mode with threat model | Medium | High | See design constraints below; significant cross-agent/platform regression burden |
| Headless launch mode | Medium | Low | Remove forced TTY for scripted agent use; preserve stdin and exit semantics; existing image-based CI remains valid |
| Declarative profiles | Medium | High | Portable settings could help teams, but YAML/parser/schema/secret precedence add maintenance. Start with Dockerfile + explicit flags; only add a narrow data format after concrete demand |

More agents are useful because they strengthen the common profile workflow, but “agent count” is not itself the goal. Claude and Codex already exist. Resolve Gemini's maintenance status before promising expanded support. Do not build a generic plugin framework to add one integration.

A proposed hardening mode should target malicious project instructions or dependencies executing through an agent. Protect non-selected host files, reduce egress and privilege, and explicitly exclude protection of writable selected files/credentials unless separately restricted. `--cap-drop=ALL`, `no-new-privileges`, and a read-only root conflict with current root setup/package installation. Network restriction needs explicit provider/package endpoints and bypass testing. Such a mode should forbid host Docker access, define SSH policy, and fail closed on unsupported setups. Merely collecting Docker flags under `--secure` would mislead users; no such flag was added.

### GitHub presentation and growth

Public repository metadata inspected on 2026-09-29: description still says “containerized sandbox wrapper” and names Gemini/Claude; topics are empty. A v0.14.1 release with an `inbox` script asset exists. Metadata changes were not applied remotely.

Priority order:

1. Lead with work/personal profile switching and a working first session, using this README. Measure whether a new developer can explain profiles after 30 seconds and authenticate without assistance; stars are an outcome, not a guaranteed result.
2. Set About description to: **“Run Claude Code, Codex, and other coding agents in disposable Docker containers with persistent profiles and custom tool environments.”** Suggested topics: `coding-agent`, `claude-code`, `codex`, `docker`, `ai-cli`, `developer-tools`, `development-environment`, `profiles`. Avoid leading with “secure sandbox.”
3. Publish the reviewed CLI changes in a release, with explicit `--` examples and no change to existing approval defaults. Keep installation and release notes synchronized; use the release history rather than inventing a retrospective changelog.
4. Show one real 15–20 second terminal recording: work login already saved → exit → personal profile → return to work. Hide secrets and label pre-authenticated sessions. Text commands are the current demo; no fabricated transcript, heavy GIF, or fake authentication output was added.
5. Share a concrete custom-tools recipe and an honest boundary diagram. A small tool users do not need to rewrite is a better hook than a long feature checklist.
6. Retain one CI badge, clear MIT license, contributor steps and issue template. Add verified host/authentication coverage over time; existing CLI smoke tests do not establish full platform support.

A long “without InBox” Docker command was deliberately omitted from the README: it would repeat details before first use and can unfairly inflate the alternative. The Why section explains exactly which conventions InBox maintains. Homebrew packaging, a branded social-preview image, private vulnerability reporting setup, and release signing are future maintainer tasks. No daemon, web UI, account service, orchestration system, or custom runtime is proposed.
