# cmux: Deep Research Synthesis

## 1. Overview

**cmux** is a free, open-source native macOS terminal built specifically for running and supervising AI coding agents (Claude Code, Codex, OpenCode, Gemini CLI, Aider, Cursor Agent, and similar). It was created by **Manaflow** — a YC S24-backed applied AI lab based in San Francisco — and launched on Show HN on **February 19, 2026**, reaching **#2 on Hacker News** and going viral on X (particularly in Japan).

The project's verbatim GitHub tagline is:

> "A Ghostty-based macOS terminal with vertical tabs and notifications for AI coding agents"

The cmux.com homepage markets it with the shorter tagline:

> "The terminal built for multitasking"

Positioning is deliberate and repeatedly emphasized by the founders:

> "cmux is a primitive, not a solution. It gives you a terminal, a browser, notifications, workspaces, splits, tabs, and a CLI to control all of it. cmux doesn't force you into an opinionated way to use coding agents. What you build with the primitives is yours. The best developers have always built their own tools."

In other words, cmux explicitly refuses to be an orchestrator, lifecycle manager, or prescriptive "agent IDE." It is a thin, native layer that sits *underneath* whatever orchestration layer you prefer — or none at all.

The origin story (quoted from the founders' Show HN post):

> "I run a lot of Claude Code and Codex sessions in parallel. I was using Ghostty with a bunch of split panes, and relying on native macOS notifications to know when an agent needed me. But Claude Code's notification body is always just 'Claude is waiting for your input' with no context, and with enough tabs open I couldn't even read the titles anymore. I tried a few coding orchestrators but most of them were Electron/Tauri apps and the performance bugged me. I also just prefer the terminal since GUI orchestrators lock you into their workflow. So I built cmux as a native macOS app in Swift/AppKit."

Founders are **Austin Wang** (CEO, @austinywang) and **Lawrence Chen** (@lawrencecchen), both Berkeley '24 graduates and former Minion AI engineers. Company X handle: **@manaflowai**.

## 2. Architecture

cmux is a genuinely native macOS app — not an Electron shell, not a Tauri wrapper, not a fork of Ghostty. It is its own application that embeds Ghostty's renderer as a library, the same way browsers embed WebKit.

**Native Swift + AppKit.** The codebase is roughly 78% Swift. Startup is fast, memory footprint is low, and the app uses native macOS conventions (window management, notifications, Sparkle auto-updates).

**libghostty rendering (GPU-accelerated).** cmux links `libghostty` — the terminal renderer Mitchell Hashimoto extracted from Ghostty — for GPU-accelerated text output. Hashimoto himself publicly praised cmux on X, citing "the programmability, layered UI, browser w/ api" as standout features. Importantly, **cmux is not a fork of Ghostty**; Ghostty remains a standalone terminal and cmux is a separate app consuming its rendering engine.

**Ghostty config reuse.** cmux reads `~/.config/ghostty/config` directly, so themes, fonts, colors, and keybindings users have already tuned for Ghostty apply automatically with no migration.

**Scriptable CLI + socket API.** Every UI action — create workspaces, open tabs, split panes, send keystrokes, open a URL in the browser pane, trigger a notification — is exposed through both a `cmux` CLI binary and a local socket API. This is the concrete technical meaning of "primitive": the UI is not privileged; it is one client of the same API you can script.

**Built-in browser pane.** The browser panel is a first-class pane type, splittable alongside any terminal pane. It carries a scriptable automation API ported from `agent-browser` that lets agents snapshot the accessibility tree, get element references, click, fill forms, and evaluate JavaScript.

**Workspaces, vertical tabs, split panes.** Workspaces are the top-level container. Each workspace has a vertical-tab sidebar showing per-tab metadata (git branch, linked PR number/status, working directory, listening ports, latest notification text). Inside each tab, horizontal and vertical splits compose terminal panes and browser panes freely.

**Session restore.** Layout, tab metadata, and scrollback are persisted and restored on relaunch — but live in-pane process state (active `tmux`, `vim`, or Claude Code sessions) is not resumed. This is an explicit known limitation.

## 3. AI Agent Features

The distinguishing features of cmux over a conventional terminal multiplexer are all about making many concurrent agents observable at a glance.

**Color-coded notification rings on pane borders.** Each pane's border can light up to signal agent state without needing to focus the pane. A blue/yellow ring indicates an agent is waiting for user input; a green ring indicates a completed task; a red ring indicates an error. The matching vertical tab in the sidebar also gets a colored badge so the state is visible even when the pane is not on screen. `Cmd+Shift+U` jumps to the most recent unread notification.

**OSC-based notification protocol + `cmux notify` CLI.** cmux listens for terminal escape sequences **OSC 9, OSC 99, and OSC 777** — the de facto notification sequences agents like Claude Code and OpenCode already emit. For agents or scripts that do not emit these sequences natively, cmux ships a `cmux notify` command that can be wired into Claude Code hooks, OpenCode hooks, Codex wrappers, shell scripts, or anything else that needs to signal the terminal.

**`cmux claude-teams` command.** A single command that launches Claude Code's teammate ("subagent swarm") mode with native cmux integration. Teammates spawn as **native split panes** — not as virtual tmux panes inside one terminal — each with its own sidebar entry, metadata, and notification ring. "No tmux required" is the explicit positioning.

**Per-tab agent context in notifications.** Instead of macOS showing the opaque "Claude is waiting for your input" with no way to tell *which* Claude, cmux surfaces the pane's git branch, working directory, listening ports, PR number/status, and the last line of notification text, so the user knows at a glance which of their twelve agents needs attention.

**Image drag-and-drop into remote sessions.** Dragging an image file onto a pane that is currently attached to an SSH session automatically triggers an `scp` upload of that image to the remote host and pastes the resulting remote path into the prompt — useful for feeding screenshots to an agent running on a remote dev box.

## 4. Remote + Browser

**`cmux ssh user@host`.** Creates a workspace bound to a remote machine. Beyond being an SSH client, the command stands up a remote daemon so subsequent splits, notifications, and browser routing all resolve through the remote context.

**Browser panes route through the remote.** When a workspace is attached to a remote host, browser panes in that workspace route their network traffic through the remote machine's localhost. A dev server listening on `localhost:3000` on the remote box is reachable as `localhost:3000` inside the cmux browser pane — no port-forwarding incantation required.

**Browser data import from 20+ browsers.** On first use, browser panes can import cookies, history, and session data from **Chrome, Firefox, Arc**, Brave, Edge, Safari, Vivaldi, Opera, and roughly a dozen more Chromium/Gecko derivatives, so the pane starts out already authenticated to GitHub, Linear, Vercel dashboards, and anything else the user is already logged into elsewhere.

**`cmux.json` custom commands.** Each project can define its own actions in a `cmux.json` file at the repo root. These appear in the command palette when the workspace is scoped to that project.

## 5. Comparison

A common source of confusion is where cmux sits relative to the wave of agent orchestrators. The clearest framing comes from the Composio Agent-Orchestrator project's own competitive discussion (discussion #526): **they operate at different layers**.

**cmux vs tmux.** tmux is a cross-platform terminal multiplexer optimized for long-running server sessions; its wins are portability, true session persistence (live process detach/reattach), and three decades of battle-testing. cmux is macOS-only and does *not* restore live in-pane processes on relaunch. cmux wins on native GPU rendering, colored notification rings, vertical-tab sidebars, a scriptable browser pane, and per-agent context in notifications.

**cmux vs Agent Orchestrator (AO, by Composio).** AO is a full lifecycle orchestrator: give it a Linear/GitHub/GitLab issue, it spawns an agent in an isolated git worktree, opens a PR, auto-fixes CI failures, routes review comments back, and escalates when stuck. **cmux is not an orchestrator; it is where agents run.** They are complementary.

**cmux vs T3 Code (Theo Browne) / Symphony (OpenAI).** T3 Code is a diff-review-focused desktop chat app. Symphony is an Elixir/OTP Linear-only orchestrator. Both are orchestrators at higher layers; cmux remains the terminal substrate.

**Layering summary:**

- **Board/tracker layer:** Linear, Jira, GitHub Issues
- **Orchestration layer:** Agent Orchestrator, OpenAI Symphony
- **Review/approval layer:** T3 Code
- **Terminal/substrate layer:** **cmux** (and tmux, iTerm2, Ghostty)
- **Agent layer:** Claude Code, Codex, OpenCode, Aider, Gemini CLI, etc.

## 6. Installation & Usage

**Install via Homebrew:**

```
brew tap manaflow-ai/cmux
brew install --cask cmux
```

**Or direct DMG:** `github.com/manaflow-ai/cmux/releases/latest/download/cmux-macos.dmg`

**Optional CLI symlink:**

```
sudo ln -sf "/Applications/cmux.app/Contents/Resources/bin/cmux" /usr/local/bin/cmux
```

**Basic commands:**

- `cmux` — launch the app
- `cmux ssh user@host` — create a remote workspace
- `cmux claude-teams` — launch Claude Code's teammate mode as native splits
- `cmux notify "message"` — emit a notification to the owning pane
- `cmux.json` at the repo root — define per-project command-palette actions

Shortcuts: `Cmd+T` new tab, `Cmd+D` split, `Cmd+Shift+U` jump to most recent unread notification.

## 7. Traction & Reception

- **GitHub stars:** ~7.7k in the first month; ~9.5k within two weeks of launch; ~15k by April 2026 (with ~1.1k forks).
- **Hacker News:** Show HN on Feb 19, 2026 hit **#2 on HN** (item `47079718`). Earlier prototype Show HN (Oct 2025, `45596024`).
- **X / Twitter:** launch tweet from Lawrence Chen went viral; Mitchell Hashimoto praised it publicly.
- **Geographic reach:** notably viral in Japan and China (official `README.zh-CN.md` and `README.es.md` exist).
- **Reported adopters:** engineers at Nvidia, Google, and OpenAI per Manaflow's messaging.
- **License:** **AGPL-3.0-or-later**, plus commercial license option via `founders@manaflow.com`.

## 8. Limitations

- **macOS only.** No Linux, no Windows, no iPad.
- **No live process state restore on relaunch.** Layout/metadata restored; live PTYs are not.
- **Young ecosystem.** Rough edges, missing keybindings, incomplete features.
- **Terminal-scope only.** Not an orchestrator — no PR lifecycle, CI retry, or cross-machine agent scheduling.

## 9. Official URLs

**GitHub & code:**
- Main repo: https://github.com/manaflow-ai/cmux
- README: https://github.com/manaflow-ai/cmux/blob/main/README.md
- CLAUDE.md: https://github.com/manaflow-ai/cmux/blob/main/CLAUDE.md
- Releases: https://github.com/manaflow-ai/cmux/releases
- Companion CLI agent repo: https://github.com/manaflow-ai/cmux-code

**Websites & docs:**
- Primary site: https://www.cmux.dev/
- Alternate / blog domain: https://cmux.com/
- Getting-started: https://cmux.com/docs/getting-started
- Changelog: https://cmux.com/docs/changelog
- Keyboard shortcuts: https://cmux.com/docs/keyboard-shortcuts
- Notifications: https://cmux.com/docs/notifications
- Blog: https://cmux.com/blog
- DeepWiki: https://deepwiki.com/manaflow-ai/cmux

**Company & founders:**
- Manaflow YC: https://www.ycombinator.com/companies/manaflow
- Manaflow on X: https://x.com/manaflowai
- Austin Wang on X: https://x.com/austinywang
- Lawrence Chen on X: https://x.com/lawrencecchen

**Product Hunt:**
- https://www.producthunt.com/products/cmux

**Discord / community:**
- Discord invite: https://discord.gg/xsgFEVrWCZ
- Community hub: https://cmux.com/community

**Hacker News discussions:**
- Show HN (Feb 19, 2026, #2 on HN): https://news.ycombinator.com/item?id=47079718
- Earlier Show HN (Oct 16, 2025): https://news.ycombinator.com/item?id=45596024

**Third-party coverage:**
- Vibecoding review: https://vibecoding.app/blog/cmux-review
- Composio competitive discussion: https://github.com/ComposioHQ/agent-orchestrator/discussions/526
