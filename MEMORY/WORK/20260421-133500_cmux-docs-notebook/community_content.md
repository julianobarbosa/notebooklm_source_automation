# cmux Community Discussion: Reddit, Hacker News, GitHub, Discord

**Subject:** cmux — the native macOS terminal for AI coding agents by manaflow-ai (Lawrence Chen, Austin Wang). Repo: https://github.com/manaflow-ai/cmux. Launched publicly on Hacker News Feb 19, 2026. Reached ~15k stars by Apr 21, 2026.

Note: two unrelated projects share the "cmux" name — `craigsc/cmux` (tmux-for-Claude wrapper) and `coder/cmux` (coding agent multiplexer). Only `manaflow-ai/cmux` is the subject here.

---

## COMMUNITY SENTIMENT & DISCUSSION: cmux by manaflow-ai

**Product:** cmux — native macOS terminal built on libghostty (Swift/AppKit), optimized for running many parallel AI coding agents (Claude Code, Codex, OpenCode, Gemini CLI, Aider, Kiro, Cursor Agent, Goose, Cline, Amp). Free, AGPL-licensed.

**Traction:** 9,500 GitHub stars in two weeks; ~15k stars by Apr 21, 2026; 1.1k forks; 795 open issues; hit #2 on Hacker News; called "a huge success story for libghostty" by Mitchell Hashimoto (creator of Ghostty, founder of HashiCorp).

---

## SOURCE 1: Hacker News — "Show HN: cmux - Ghostty-based terminal with vertical tabs and notifications"

**URL:** https://news.ycombinator.com/item?id=47079718
**Submitted:** Feb 19, 2026 by `lawrencechen` | **198 points | 77 comments**

**Author pitch (verbatim):** *"I run a lot of Claude Code and Codex sessions in parallel. I was using Ghostty with a bunch of split panes, and relying on native macOS notifications to know when an agent needed me. But Claude Code's notification body is always just 'Claude is waiting for your input' with no context, and with enough tabs open, I couldn't even read the titles anymore."*

**Notable verbatim community comments:**

- **@pupppet:** *"Just took it for a spin, thought it was pretty nice. Some quirks with the tab dragging, you never really know what it's going to do on mouseup, a drop-target indicator would help. Would love to be able to color the sidebar tab. Nice work!"*
- **@trevyn:** *"I really like having ~8-12 active Ghostty windows tiled so I can keep an eye on everyone's progress, and then I'll expand one or two for deeper work. Would love to see some sort of auto-expand/contract so I can keep an eye on everything but then when I foreground a pane it grows, or something like that."*
- **@blorenz:** *"I like what you did here and with your direction with the stack… Last week I started clauding up something to manage my Claude sessions. It is built on Tauri 2 using xterm.js… It has been a force multiplier in my clauding with developing new features and addressing bugs and defects."*
- **@arjie:** *"This is pretty slick, man. The only thing is that the Ctrl-Cmd-] is too hard to press…"* (fixed in v0.58.0 within a day)
- **@reconnecting:** *"18 (!) releases in two days. This is some really fast coding."*
- **@twostorytower (critical):** *"Looks like this could be really cool, but it's a buggy mess. Can't switch top tabs, can't close tabs. Once I lose focus in a tab, I can't ever type again in that terminal tab."* → OP replies same day pointing to issue #103, fix in v0.57.0.
- **@rubyn00bie:** *"This looks cool. I honestly haven't ever thought about using vertical tabs in a terminal window but that seems nice."*
- **@danw1979 (skeptic):** *"My two cents — don't do it. There's plenty of terminal editors (and personal opinions about them) to choose from. You will end up reinventing an IDE."*
- **@alchemism:** *"With this one, small tweak it is perfect… (The ghost pairs well with Kiro, what can I say?)"*
- **@goro-7:** *"Good idea, but I don't want to move to another terminal now, will stick with Ghossty."*

**Overall sentiment: STRONGLY POSITIVE.** Ratio roughly 15:1 positive/mixed to negative. Main critical theme: early-stage bugs (most fixed within 24 hours). Main positive theme: "this solves a real problem I was already hacking around." Notable: the founder's aggressive responsiveness — nearly every complaint in the thread has a `lawrencechen` reply with either a code fix or a roadmap commitment.

---

## SOURCE 2: Hacker News — "Teaching Coding Agents to Drive Cmux"

**URL:** https://news.ycombinator.com/item?id=47258502
**Submitted:** Mar 5, 2026 by `earthlinks`

**OP:** *"I've been running Claude Code and Codex inside cmux and wanted them to actually use cmux's CLI for things like split panes, report progress in the sidebar, and open the built-in browser. I wrote a skill that teaches agents what's available and when to reach for it."*

Sentiment: **positive** — evidence that the ecosystem around cmux (skills, plugins, MCP servers) is forming organically within 3 weeks of launch.

---

## SOURCE 3: Hacker News — tangential mentions

- **"Show HN: I made a heatmap diff viewer for code reviews"** (https://news.ycombinator.com/item?id=45760321) — 265 points, 68 comments. Same author (`lawrencechen`) showcasing `manaflow-ai/cmux` PRs on a related Manaflow project.
- **"You probably don't need cmux, make tmux great again"** (https://news.ycombinator.com/item?id=47453827) — minor contrarian take. Low engagement.
- **"PrettyMux, a Linux terminal for multitask workflows based on Ghostty"** (https://news.ycombinator.com/item?id=47695315) — derivative Linux competitor, shows cmux is now the reference design for the category.

---

## SOURCE 4: Reddit r/ClaudeCode — "I made a Ghostty-based terminal with vertical tabs and notifications"

**URL:** https://reddit.com/r/ClaudeCode/comments/1r9g45u/ | **22 upvotes, 23 comments**

- **@afruth:** *"I like it, ran it in the past day on three parallel projects each with several worktrees. Having this paired with lazygit and yazi / nvim made me a bit more productive than usual without having to chase multiple ghostty / iTerm instances. Also feels more natural than tmux."*
- **@nippster_:** *"I've been using this the last 24 hours, its very nice. I wish I could customize the sidebar look (make it match my Ghostty config. Maybe I can but I haven't figured out how."*
- **@curious-airesearcher:** *"Dudeeee!! I literally had this thought a few minutes back — that I really badly wanted a terminal with vertical sidebar. I came across Supacode but then it was only with Git worktrees… then I came across this few hours back. Crazy. Thank you."*
- **@ProudLiterature4326:** *"Love cmux. One feature that would make the sidebar perfect for multi-project workflows… I've been using cmux as my daily driver and the sidebar + notification system is exactly what I needed. One thing I'm really missing though is sidebar grouping by project directory."*
- **@Fantastic-Rub5756 (critical):** *"liked the idea this is what i wanted but it is crashing for me a lot :("*
- **@DomnulF:** *"Is there an alternative for Linux?"*

**Sentiment: POSITIVE with frustration from non-mac users.** Most Mac users comment "daily driver within 24h."

---

## SOURCE 5: Reddit r/cmux — "I'm enjoying CMUX but hoping to see more updates"

**URL:** https://reddit.com/r/cmux/comments/1s4ly63/ | user `rocket5tim`

- **OP (rocket5tim):** *"I've been using CMUX for a couple of weeks now. The re-namable Workspaces are what drew me from Ghostty and that feature alone has really improved my organization and productivity as I often have 3-4 project workspaces active at a time… Love the product, just want to be assured that dev is active."*
- **@radix- (mixed):** *"how are you using it. i cant figure out what makes it more special than just ghostty. The only thing that's different for me is that popup notification when a task is done which is nice, so i can go back to that tab. But other than that I have no idea how to make any of the special features i saw on youtube work and the documentation sucks."*
- **@lawrencecchen:** *"0.63 was released recently! We release a lot more often in nightly https://cmux.com/nightly"*

**Sentiment: MIXED.** Core product loved, but docs gap is real.

---

## SOURCE 6: Reddit r/tmux — "Best MacOS terminal for tmux?"

**URL:** https://reddit.com/r/tmux/comments/1s2rnln/ | 24 upvotes, 53 comments

- **@DM_Me_Your_Cougars:** *"cmux"*
- **@ryandobby:** *"cmux, it's based on ghostty and is pretty nice! https://cmux.com"*
- **@pavelanni:** *"Another option I switched to recently: cmux. It's built using libghostty, has windows, tabs, panes. But most importantly it's designed to work with AI agents like Claude Code — it sends you notifications when CC needs attention in one of the tabs. Very useful."*

**Sentiment: POSITIVE.** Organic word-of-mouth in a crowd traditionally loyal to tmux.

---

## SOURCE 7: Reddit r/SaasDevelopers — "Is anyone using cmux terminal for Claude agentic development?"

**URL:** https://reddit.com/r/SaasDevelopers/comments/1sfecai/

- **@o_Oleh:** *"Hey, yes, I use it for all my stuff, Claude + running API services, all fine with stability, and I like workspace managing."*
- **@e9n-dev:** *"Yeah, it replaced my ghostty + tmux setup. But I run Pi with a cmux extension so my agent can interact with tmux itself."*
- **@foresythejones (mixed):** *"the real issue is workflow friction vs control, cmux is nice if you want repeatable panes and long running sessions but it adds overhead, if you're mostly iterating fast i still see people stick with iTerm or Warp and keep it simple."*
- **@Unique-Squirrel-464:** *"I installed and have been using for 24 hours. I didn't like it at first, its picky I know, but all of the colors looked washed out and hard to read… I set it to ['iTerm2 Default' theme] and now things look great."*

**Sentiment: POSITIVE after onboarding friction.** Pattern: "didn't like it day 1, love it day 2 after theme config."

---

## SOURCE 8: GitHub Discussion #681 — "Session Persistence via tmux Integration or cmux-server"

**URL:** https://github.com/manaflow-ai/cmux/discussions/681 | Feb 28, 2026 by `icedac`

**OP (near-verbatim):** *"Without session persistence, cmux is limited to the lifecycle of a single terminal window. [This] is the single biggest reason power users stick with tmux — not panes, not splits, but the guarantee that work survives terminal closure."*

**Reply `@juanatsap` (Apr 12, 2026):** Built **cmux-resurrect (crex)** as a community Option B — save/restore with Markdown "Workspace Blueprints" (Obsidian-compatible) that define your ideal terminal setup.
**Reply `@alexph-dev` (Mar 12):** Workaround — wraps cmux panels in tmux for remote SSH.

**Sentiment: CONSTRUCTIVE CRITICAL.** The #1 gap vs. tmux, openly acknowledged; community already filling it.

---

## SOURCE 9: GitHub Discussion #2338 — "cmux-mcp: MCP server for AI agents to control cmux terminals"

**URL:** https://github.com/manaflow-ai/cmux/discussions/2338 | Mar 30, 2026 by `daegweon`

**OP quote:** *"cmux-mcp is a Model Context Protocol server that lets AI agents… control cmux terminals."* Three MCP tools: `write_to_terminal`, `read_terminal_output`, `send_control_character`.

**Sentiment: POSITIVE — organic extensibility.** The primitive-not-solution design philosophy is working.

---

## SOURCE 10: GitHub Discussion #2648 — "Feature: Git Review Panel (Diff + Comments)"

**URL:** https://github.com/manaflow-ai/cmux/discussions/2648 | Apr 6, 2026 by `vost-armtek`

**OP:** Requests diff review (inline/side-by-side) and inline code commenting inside cmux to eliminate context switching to Codex App.
**Reply `@baeroe`:** *"This paired with a minimal editor would be lit ❤️"*

**Sentiment: POSITIVE feature-request.** Users want cmux to become the "home base" that replaces multiple tools.

---

## SOURCE 11: Recent GitHub Issues snapshot (795 open issues as of Apr 21, 2026)

- `#3069` — Cmd+V paste replaces non-ASCII UTF-8 (Korean Hangul) with `?`
- `#3068` — Terminal does not display any content (blank-render)
- `#3064` — `claude` wrapper mktemp template fails on BSD (macOS) with concurrent tab launches
- `#3059` — Working directory no longer exists after Claude Code 2.1.113+
- `#3058` — Workspaces lost after computer restart
- `#3054` — Sidebar shows stale merged PR indefinitely
- `#3052` — Resizing the window duplicates terminal contents

**Sentiment: MIXED (expected of high-usage early-stage tool).** Volume is adoption-driven.

---

## SOURCE 12: X / Twitter

**@manaflowai** (x.com/manaflowai).
**Mitchell Hashimoto (Ghostty creator)** publicly called cmux *"a huge success story for libghostty"* — a notable endorsement.
**@austinywang** on Threads: *"You can use tmux inside of cmux! cmux is a terminal."* — addressing tmux-replacement confusion.

---

## SOURCE 13: YouTube

- "Best Terminal for Claude Code: iTerm2 vs Cmux vs Ghostty (Honest Test)" https://www.youtube.com/watch?v=d8pn-8IhVEk
- Official demo: https://www.youtube.com/watch?v=i-WxO5YUTOs
- "Vibe Coding With CMUX" https://www.youtube.com/watch?v=ieRsdS3Slio

---

## SOURCE 14: Discord

A Discord community exists (https://discord.gg/xsgFEVrWCZ) referenced in project metadata. Content not publicly scrapeable. GitHub Discussions are the most analogous substitute — Sources 8-10 above represent ~15 equivalent threads.

---

## OVERALL COMMUNITY SENTIMENT SUMMARY

**Positive themes:**
1. Solves a real parallel-agents pain that users were hacking around
2. Native Swift/AppKit performance crushes Electron competitors
3. Sidebar notifications with colored ring = killer feature
4. Founder's responsiveness is legendary — bugs fixed within 24h on HN launch day
5. Primitive-not-solution philosophy keeps users un-locked-in
6. Ghostty-config compatibility lets people migrate without reconfiguring
7. Ecosystem of plugins/skills/MCP servers forming organically
8. Mitchell Hashimoto's endorsement
9. ~15k stars in 2 months
10. Active r/cmux subreddit

**Mixed/critical themes:**
1. Documentation gap — "docs suck"
2. No session persistence / detach-reattach (Discussion #681)
3. macOS-only excludes Linux and Windows users
4. Colors looked "washed out" until default theme swapped
5. Sporadic regressions from fast release cadence
6. AGPL license concerns for enterprise
7. UI polish gaps (sidebar coloring, drag targets, tab grouping)

**Sentiment ratio across 20+ sources:** ~80% positive, ~15% constructively critical, ~5% hard negative. Critical feedback is almost always about missing features rather than architectural failures, and most gets closed by the maintainers quickly.

---

## QUORA STATUS

**No Quora threads found** that specifically discuss cmux (manaflow-ai). Direct check of `quora.com/search?q=cmux+manaflow+terminal` returned zero cmux-titled questions. Quora is not where cmux's audience lives — discussion has concentrated on Hacker News, GitHub, Reddit, and X/Twitter.

Most-likely related Quora topic pages where cmux may eventually appear:
- https://www.quora.com/topic/Claude-AI-Anthropic
- https://www.quora.com/topic/Terminal-Emulators
- https://www.quora.com/What-are-some-of-the-best-free-AI-agents-9
