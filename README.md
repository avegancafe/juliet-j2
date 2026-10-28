# juliet-j2

The J2 work layer for [Juliet](https://github.com/avegancafe/Juliet): only the
things you need to work at J2, layered on top of Juliet's shared setup. It
doesn't include anyone's personal apps or preferences. Put yours in your own
extension (see "Adding your own layer" below).

## What it adds

| | |
|---|---|
| **Claude Code** | The `j2-claude-plugins` marketplace and every J2 plugin (`j2-eng`, `compliance`, `j2-presentations`, `j2-sandbox`, the J2 forks of superpowers/codex/playwright, dbt, LaunchDarkly, the Python and TypeScript LSPs, …), Sentry, and `Bash(j2/gcloud/kubectl *)` permissions. Merged into `~/.claude/settings.json` from [`claude/settings.json`](claude/settings.json). |
| **Packages** | `gcloud-cli` and `kubernetes-cli` on macOS; `kubernetes-client` on Fedora |
| **dev-env** | Clones `j2-health/dev-env` to `~/workspace/dev-env` (it needs `gh auth login` first), and fish sources its initializers, which provide the `j2` CLI |
| **fish** | `logs`: pick a J2 service with fzf and tail its App Engine logs |
| **opencode** | Reminds you to run `j2 bootstrap`, which installs the team's global `opencode.json` |

## Install

1. Install Juliet: follow its README. When the first `juliet-bootstrap` run
   asks for an extension, paste the URL below.
2. Or set it yourself in `~/.config/local/.env`:

   ```
   JULIET_EXTENSION=https://github.com/avegancafe/juliet-j2.git
   ```

3. Then:

   ```bash
   gh auth login          # your J2 GitHub account: dev-env is private
   juliet-bootstrap
   j2 bootstrap           # in a new shell
   ```

Bootstrap keeps this repo up to date by pulling it on every run.

## Adding your own layer

`JULIET_EXTENSION` takes a list, applied in order. Keep work and personal
setup separate:

```
JULIET_EXTENSION="https://github.com/avegancafe/juliet-j2.git https://github.com/you/juliet-you.git"
```

Your personal laptop can list just your own extension, and nothing from J2 gets
installed. Start yours from Juliet's
[`extension-template/`](https://github.com/avegancafe/Juliet/tree/main/extension-template).

## Keep this repo clean

This repo is **public**. Never commit internal hostnames, cluster or bucket
names, project IDs, or secrets. Machine-specific Claude settings, such as an
auto-mode `environment` block describing J2 infrastructure, go in
`~/.config/local/claude/settings.json`. That file is merged last and never
committed.
