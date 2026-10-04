## Running in CI (GitLab Runner)

Use InBox images directly in CI. The `inbox` launcher requires an interactive terminal.
This example runs Claude in GitLab CI with a saved `work` profile.

### GitLab Runner setup

1. On the runner host, [sign in to Claude](./claude/getting_started.md) with profile `work`, then exit.
   Note that user's ID with `id -u`.

2. Configure a Docker executor runner. In its `config.toml`, mount that user's profile:

   ```toml
   [runners.docker]
     volumes = ["/home/<runner-user>/.inbox/claude-work:/home/inbox"]
     pull_policy = "always"
   ```

   Replace `<runner-user>` with the actual host user. Use a dedicated CI account and profile.
   Jobs using this mount can read its credentials.

### Job definition example

Add this job to `.gitlab-ci.yml`. Replace `1000` with the profile owner's user ID:

```yaml
ai-run:
  image: ghcr.io/hiochiai/inbox:latest-claude
  variables:
    HOST_UID: "1000"
  script:
    - claude -p "Explain this project" --dangerously-skip-permissions
```

Keep the image's entrypoint. The job runs as `inbox` with `HOME=/home/inbox`.
This example explicitly skips agent approval prompts. Provider access and usage charges still apply.

### How it works

GitLab sets `CI=true`. When `CI` is set and the first argument is an executable command, the entrypoint runs that command.
It first sets up the user ID and permissions. This lets the runner start its job shell.

| Interactive launcher behavior | CI configuration |
| --- | --- |
| Mount the selected profile | Set a volume in runner configuration |
| Pass the host user ID | Set `HOST_UID` to the profile owner's ID |
| Add default agent arguments | Choose explicit arguments in the job script |
| Select an image | Set the job's `image` |

[Documentation index](./README.md) · [CLI reference](./cli_reference.md)
