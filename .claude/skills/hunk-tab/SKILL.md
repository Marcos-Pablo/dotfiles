---
name: hunk-tab
description: Open (or reuse) a herdr tab that reviews a diff in the hunk TUI, so the user can eyeball changes visually. Use when you've made code changes and want the user to look them over before staging or committing, or when the user asks to "review", "see", or "look at" a diff, a commit, or a branch comparison. This is the launcher; to annotate the diff with inline comments once it's open, use the separate `hunk-review` skill (hunk's own). Requires herdr and hunk installed and a herdr session running.
---

# hunk-tab

Launches — or **reuses** — a herdr tab running [hunk](https://github.com/), a
terminal diff viewer, so a diff shows up in front of the user. This skill owns
only the **tab orchestration**; the built-in **`hunk-review`** skill owns
inspecting/navigating/commenting on the live session once it's open. Don't
duplicate that here — open the tab, then hand off to `hunk-review`.

**One live session per repo/worktree**, keyed by the repo root. Git worktrees
report their own toplevel, so each worktree is its own session. If a diff tab
for the current repo/worktree is already open, the script **reloads it in
place** instead of piling up duplicates; otherwise it launches a fresh one with
`--watch` so the pane auto-refreshes as files change. Tabs are labeled
`diff · <repo-or-worktree-name>`. Address a session from anywhere with
`--repo <its root>`.

## When to use

- After you finish a set of edits and want the user to review before you
  stage/commit.
- The user asks to review / see / look over a diff, a commit, or a branch delta.
- You want to point the user at a specific comparison (e.g. `main...HEAD`).

Don't use this to read the diff *yourself* — it opens an interactive TUI for the
*human*. To read a diff programmatically, use `git diff` (or the `hunk-review`
skill's `hunk session review --repo <root> --json`).

## Open (or reuse) the tab

```bash
~/dotfiles/.claude/skills/hunk-tab/hunk-tab [--keep] [--no-watch] [-- <hunk args...>]
```

| Goal                                   | Command                     |
| -------------------------------------- | --------------------------- |
| Working-tree changes (default)         | `hunk-tab`                  |
| Staged changes only                    | `hunk-tab --staged`         |
| Compare against a branch               | `hunk-tab main...HEAD`      |
| Review a specific commit               | `hunk-tab show HEAD~1`      |
| Limit to a pathspec                    | `hunk-tab -- diff -- src/`  |
| Keep the tab open after quitting hunk  | `hunk-tab --keep`           |
| Don't auto-refresh (no `--watch`)      | `hunk-tab --no-watch`       |

Everything after the leading options is forwarded to `hunk` verbatim; with no
arguments it runs `hunk diff` (working tree). Run it from inside the repo /
worktree you're reviewing — the label and session are keyed off its root.

The script blocks until hunk's session daemon can see the session, then prints
one of:

```
hunk-tab: opened <tab> (diff · <name>) in <root>
hunk-tab: session ready — annotate with: hunk session comment ... --repo <root>
```
```
hunk-tab: reloaded <tab> (diff · <name>) in <root>     # an existing tab was repointed
```

Re-running with a different target (e.g. `hunk-tab show HEAD~1`) **repoints the
same tab**; the underlying primitive is `hunk session reload --repo <root> --
<args>`.

## Then: annotate via the `hunk-review` skill

Once you see `session ready` (or `reloaded`), if you want to leave inline notes
explaining the changes **you** made, switch to the **`hunk-review`** skill — it
covers `hunk session review` (find valid comment targets),
`hunk session comment add/apply` (leave notes), and `navigate`. Pass it
`--repo <root>` from the line above to target this session. Keep notes on hunks
you authored; they live only in the running session.

## Hand off

Tell the user the tab is open and what they're looking at. The tab is ephemeral
— it disappears when they press `q` in hunk (which also drops any notes); pass
`--keep` if it must persist.

The script **never switches the user across workspaces**: it opens/reloads the
tab in the calling pane's workspace and only brings it to the front when the
user is already viewing that workspace. If output includes
`left your focus where it is`, relay *which workspace* the tab is in (from the
message) so the user can go to it when ready.

## Requirements & failure modes

- Needs a running **herdr** session; if none is attached, the script exits with
  `could not create a herdr tab` and prints the raw error.
- Needs `herdr`, `hunk`, and `jq` on PATH (falls back to the mise install of
  herdr and the brew path for hunk).
- `could not reload the session … (multiple sessions?)` → more than one hunk
  session shares this repo root; close the extras or target one by session id.
- hunk's theme is configured separately in `~/.config/hunk/config.toml`.
