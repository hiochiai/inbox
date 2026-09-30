## Pass arguments to antigravity

Run in your **host terminal** with InBox installed and Docker running.

```bash
inbox antigravity -p work -n -- --help
```

The output should be the agent’s help. The first separator is consumed by InBox; all following arguments are passed unchanged.

See [Pass agent arguments](../passing_arguments.md) for the full procedure and checks. For option defaults and migration requirements, see the [CLI reference](../cli_reference.md).

[Documentation index](../README.md) · [antigravity authentication](./getting_started.md)
