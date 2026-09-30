## Passing arguments to Antigravity

```bash
inbox antigravity --version
inbox antigravity --help
```

InBox consumes `-p` as its profile selector. It is not an Antigravity prompt option. Check agent help for alternatives to conflicting options.

InBox adds `--dangerously-skip-permissions` by default. Omit it with:

```bash
inbox antigravity -n
```
