## Passing Arguments to Gemini

You can pass arguments directly to the Gemini agent. Any arguments that are not recognized by `inbox` will be passed to the agent.

```bash
# Get help for the Gemini agent
inbox gemini --help
```

### Default Arguments

By default, `inbox` starts the Gemini agent with the `--yolo` flag for a streamlined experience.

If you need to run the agent without this default, use the `-n` or `--no-defaults` flag.

```bash
# Run Gemini without any default arguments
inbox gemini -n
```
