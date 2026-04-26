# claude-mem :: docs — Studio + Prompt Output

Generated 2026-04-21 from NotebookLM notebook `53a24a23-12bb-4160-a637-0c9b9ea19352` (64 sources on [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem)).

**Notebook:** https://notebooklm.google.com/notebook/53a24a23-12bb-4160-a637-0c9b9ea19352

---

## Studio Artifacts (11 generated)

| Type | Title | Link |
|---|---|---|
| Audio Overview | *Claude-Mem prevents AI context rot* | [audio (m140)](https://lh3.googleusercontent.com/notebooklm/AKXwDQFBUyh6bRU_pRjSghNyXaERt3lMDoKggxxlfxwUXNRl5p2AVF08DF4PdQIlqEHz9k9N4SBfryGmW-s-0BWLcSTdQlDQUZCRy6tkWDrccLADR2lNG1LImF_BAEyYR3_eYGAovWcp_GzdDm4MZrdO5TS9TnwPuhg=m140-dv) |
| Video Overview | *Taming the Token Beast* (whiteboard style) | [video (m22)](https://lh3.googleusercontent.com/notebooklm/AKXwDQG7qfO1ZIVNDcHKfZqgn_kAWf1qMutLPb6QwWp0vH3GPpTC9NYIBnrDozpDiKbbcRRRdwN1quYByIlOaKLYfxET1TFLg1hY2ejKM6XUpTtCks-55GnRNZVzXrBt3gbDZzM9OdyQK011_apRlyTdQAoW0xMx8g=m22-dv) |
| Mind Map | *Arquitetura Claude: SDK, Memória e Integração de Agentes* | Open in notebook (root: Claude Agent SDK & Claude-Mem, 4 children) |
| Quiz | *Claude-Mem Quiz* (15 questions, medium) | Open in notebook |
| Flashcards | *Claude-Mem Flashcards* (9 cards) | Open in notebook |
| Slide Deck | *Agent Context Economics* (detailed deck) | [PDF download](https://contribution.usercontent.google.com/download?c=Cgpub3RlYm9va2xtEkYSD2FydGlmYWN0c19tZWRpYRozCiRiZDAzMDYyYi1jZDc2LTRkMmItODJiZi04MTJhM2I5MGQxMTISCxIHEOP2juTZFhgB&filename=Agent_Context_Economics.pdf&opi=96797242) |
| Report (Briefing Doc) | *Claude-Mem: Persistent Memory Architecture and Context Engineering* | Open in notebook |
| Report (Study Guide) | *Claude-Mem: A Comprehensive Study Guide for Context Engineering* | Open in notebook |
| Report (Blog Post) | *Never Forget a Line: Mastering Persistent Memory with Claude-Mem* | Open in notebook |
| Infographic | *AI Context Engineering Guide* (landscape, detailed) | [infographic image](https://lh3.googleusercontent.com/notebooklm/AKXwDQEVRG8CI2fIhj9BhwaeDaAfaiq8v3pQ-m9lXloH84oQQ7q3nj4ihiMOYJKmImXgitksJIkXNpOiDtCzLFzbfHoOc1E3nJKKY9ac_Xp2xSR0MsOFoJbPDsM9hD74EWttyhjbmupN_VKze9E6B3hnKNGLcnjVYg=w2752-d-h1536-mp2) |
| Data Table | *Claude-Mem Subsystems Comparison* | Open in notebook |

Artifact-level URLs (audio/video/slides/infographic) are Google-signed — may require NotebookLM auth or may expire. The notebook page always has the live versions.

---

## Prompts — XDA Article (3)

Source: [xda-developers.com/prompts-i-use-to-get-most-out-of-noteboooklm/](https://www.xda-developers.com/prompts-i-use-to-get-most-out-of-noteboooklm/)

### 1. Five Essential Questions

> 1.) Analyze all inputs and generate 5 essential questions that, when answered, capture the main points and core meaning of all inputs. 2.) When formulating your questions: a. Address the central theme (or themes if there are many) or argument (or arguments if many). b. Identify key supporting ideas c. Highlight important facts or evidence d. Reveal the author's purpose or perspective e. Explore any significant implications or conclusions. 3.) Answer all of your generated questions one-by-one in detail.

**Answer:**

**Q1. What is the central argument behind Claude-Mem's "progressive disclosure" philosophy, and how does it solve the problem of AI context pollution?**
The central argument is that an AI model's context window is a finite resource governed by an "attention budget," and simply dumping large amounts of historical data into it causes "context rot." Traditional RAG wastes up to 94% of that budget on irrelevant context. Claude-Mem solves this with **progressive disclosure** — a 3-layer workflow where Layer 1 (Index) injects a lightweight metadata timeline with token-cost estimates (~50–100 tokens per result), Layer 2 (Context/Timeline) provides chronological narrative around a specific event, and Layer 3 (Deep Dive) fetches full observations only when needed. This reduces context waste by 87–96%.

**Q2. How does the system's underlying architecture support autonomous, background memory capture without interrupting the user's workflow?**
Claude-Mem uses a non-invasive, hook-driven architecture decoupled from a background worker service. Because the Claude Code binary is closed-source and sessions cannot be slowed, the system integrates via 5 lifecycle hooks: **SessionStart** (silent context injection), **UserPromptSubmit** (init session, save prompt), **PostToolUse** (capture tool I/O, enqueue), **Stop** (trigger AI-generated summaries), **SessionEnd** (cleanup). All hooks use a fire-and-forget pattern — they POST to a local worker on port 37777 with a 2-second timeout and immediately return control. The worker then uses Claude/Gemini/OpenRouter to semantically compress raw transcripts at 10:1 to 100:1 ratios.

**Q3. What quantitative evidence and key features demonstrate Claude-Mem's efficiency in managing tokens during code exploration?**
Three features deliver the savings. **3-Layer MCP Workflow**: ~10x token savings vs. traditional RAG by forcing index-first queries. **File Read Gate**: intercepts file reads via PreToolUse hook and injects a ~370-token timeline of past work instead of letting Claude spend 5,000–50,000 tokens on the full file — 75–97% savings. **Smart Explore**: uses tree-sitter AST parsing instead of Glob/Grep/Read cycles — cross-file symbol discovery is 17.8x cheaper (~14,200 vs. ~252,500 tokens), targeted reads are 19.4x cheaper, and the system is 10–30x faster overall.

**Q4. What was the purpose behind the architectural evolution from PM2 to Bun, and what were its significant implications for the software?**
The v7.1.0 migration from PM2 + `better-sqlite3` to a custom Bun `ProcessManager` + `bun:sqlite` was driven by the need to simplify dependencies, improve cross-platform reliability, and eliminate native compilation issues. Windows previously required Visual Studio Build Tools, Python, and C++ compilers just to install the DB driver. The Bun migration achieved: (1) zero external npm dependencies, (2) built-in SQLite with no native compilation and synchronous high-performance access, (3) flawless cross-platform support — fixing console popups, zombie processes, and signal-handling bugs.

**Q5. How does the author balance the aggressive tracking of agent memory with data privacy and system resilience?**
Three principles govern the balance. **Edge Processing for Privacy**: `<private>` tags are stripped at the hook layer before data reaches the worker or database; the AI can use sensitive content during the live session but it never persists. **Graceful Degradation**: "Graceful Beats Aggressive" — if the worker crashes or DB locks, hooks fail-open (exit code 0) so the primary Claude Code UX never breaks. **Anti-Pattern Eradication**: comprehensive audits removed empty catch blocks and giant try/catch wrappers that caused silent failures and zombie processes — while still logging specific failures for debugging.

---

### 2. Find the Interesting Bits

> What are the most surprising or interesting pieces of information or narratives in these sources? Include key quotes.

**Answer:**

**A 3-Month Developer Battle Against the AI's "Complexity Bias."** A changelog entry titled *"The 3-Month Battle Against Complexity"* records the maintainer's fight against Claude's tendency to over-engineer: *"For three months, Claude's instinct to add code instead of delete it caused the same bugs to recur. What should have been 5 lines of code became ~1000 lines, 11 useless methods, and 7+ failed 'fixes.'"* And: *"The user stated 'hooks provide session IDs, no extra management needed' seven times across months. Claude didn't listen."* The fix was deleting 984 lines, leaving ~10 lines of logic.

**"Zombie Process" Apocalypses.** A missing connection mutex produced a spawn storm that caused *"641 chroma-mcp Python processes to spawn in ~5 minutes, consuming 75%+ CPU and ~64GB virtual memory."* A separate orphan bug accumulated *"155 processes consuming 51GB RAM."* Fixing both required a 5-Layer Defense system with an aggressive "orphan reaper."

**"Biomimetic" Endless Memory Architecture.** To defeat the O(N²) scaling that crashes sessions after ~50 tool uses, Endless Mode implements a *"biomimetic memory architecture inspired by how human memory works"* — synchronously compressing the AI's own output, rewriting the transcript on disk, and resuming with only the compressed memory to achieve O(N) linear complexity.

**The Rogue Crypto Token Adoption.** Unusually for an IDE plugin: *"$CMEM is a solana token created by a 3rd party without Claude-Mem's prior consent, but officially embraced by the creator of Claude-Mem (Alex Newman, @thedotmack)."*

**Treating Token Budgets Exactly Like Human Money.** Progressive disclosure is framed with an economic metaphor: traditional AI context is *"Spending your entire paycheck on groceries you might need someday."* And the governing design rule: *"If a human engineer can't definitively say which tool to use in a given situation, an AI agent can't be expected to do better."*

---

### 3. Quiz Show (adapted from OOP to claude-mem)

> You're hosting a fun quiz show with two hosts. The first host quizzes the second on concepts from the uploaded sources on claude-mem (the persistent memory compression system for Claude Code). Include a mix of multiple choice and true/false questions covering: hooks architecture, progressive disclosure, File Read Gate, Chroma vector DB, SQLite layer, the Bun migration, and the CLI. Occasionally, the second host should get an answer wrong, and the first host should step in to explain the correct answer in a clear and concise way. At the end, share the final score and a brief summary of how the second host did.

**Answer — Memory Lane, hosted by Quincy featuring Casey:**

**Q1 (MC) Hooks Architecture.** What are the 5 core lifecycle hook stages? → **B) SessionStart, UserPromptSubmit, PostToolUse, Stop, SessionEnd**. ✅ Casey correct.

**Q2 (T/F) Progressive Disclosure.** "Progressive disclosure means fetching all historical data upfront." → **False.** ❌ Casey wrong. Quincy explains: it shows an index first, letting the agent decide what to fetch — ~10x token savings via the 3-layer search/timeline/get_observations workflow.

**Q3 (MC) File Read Gate.** What file size bypasses the gate? → **B) Files under 1,500 bytes.** ✅ Casey correct. Generating the timeline index would cost more tokens than letting Claude read the file directly.

**Q4 (T/F) Bun Migration.** "Users must manually uninstall PM2." → **False.** ❌ Casey wrong. The PM2→Bun and `better-sqlite3`→`bun:sqlite` migration is completely automatic, triggered on the first hook execution after update.

**Q5 (MC) Chroma Vector DB.** Primary role? → **C) Enable semantic search via vector embeddings.** ✅ Correct. Powers hybrid search alongside keyword matching; in newer versions connects persistently via `chroma-mcp` to avoid native binary compilation.

**Q6 (T/F) SQLite Layer.** "Uses basic LIKE operators." → **False.** ✅ Correct. Uses FTS5 virtual tables for fast full-text search across sessions, observations, and prompts.

**Q7 (MC) CLI Recovery.** Safest way to recover stuck queue? → **B) Interactive CLI `bun scripts/check-pending-queue.ts`**. ✅ Correct. Shows queue summary and prompts for confirmation.

**Final Score:** Casey 5/7. Strong grasp of technical stack (hooks, FTS5, Chroma, CLI recovery). Stumbled on architectural philosophy (misunderstanding progressive disclosure as upfront dumping) and migration mechanics (thinking Bun migration was manual).

---

## Prompts — AIFire Article (6)

Source: [aifire.co/p/6-notebooklm-prompts-that-do-your-hard-work-for-you](https://www.aifire.co/p/6-notebooklm-prompts-that-do-your-hard-work-for-you)

### 4. Content Analyst

> Act as a content strategy expert. Based on the sources provided, create a full analysis with the following structure: 1. Quick Summary: Give 3 bullet points that summarize the most important ideas and conclusions about claude-mem. 2. Deep Analysis: Target Audience, Main Arguments, Best Quotes. 3. Creative Ideas: Alternative Titles, Social Media Content.

**Answer:**

**1. Quick Summary**
- **Persistent AI Memory.** Claude-mem is a memory compression system built for Claude Code / Cursor-style IDEs that prevents AI agents from forgetting past sessions; it auto-captures tool usage, generates semantic summaries, and injects context into future interactions.
- **Token-Efficient Progressive Disclosure.** Instead of dumping history into the context window like traditional RAG, claude-mem uses a 3-layer workflow (Index → Timeline → Details) for ~10x token savings.
- **Non-Invasive Architecture.** Entire system runs in the background via 5 lifecycle hooks (SessionStart, UserPromptSubmit, PostToolUse, Stop, SessionEnd) and an asynchronous Bun-managed worker, never blocking the coding session.

**2. Deep Analysis**

*Target Audience:* Developers, engineers, and AI-assisted knowledge workers using CLI tools (Claude Code, Gemini CLI) or IDEs (Cursor) for long multi-session projects. Secondary: power users running specialized Mode System workflows (law study, email investigations).

*Main Arguments:*
- Context is a finite currency; LLMs operate on an "attention budget" that depletes as context grows — overloading causes "context rot."
- Progressive Disclosure beats traditional RAG: RAG wastes up to 94% of attention budget on irrelevant context; index-first + on-demand fetch reduces cognitive load and maximizes relevance.
- AI should be the compressor: keyword extraction is inefficient; semantic compression by the AI itself achieves 10:1 to 100:1 ratios.
- Graceful architecture over aggressive execution: fail gracefully, never interrupt the user's workflow.

*Best Quotes:*
- *"Find the smallest possible set of high-signal tokens that maximize the likelihood of your desired outcome."*
- *"If a human engineer can't definitively say which tool to use in a given situation, an AI agent can't be expected to do better."*
- *"The best interface is one that disappears when not needed, and appears exactly when it is."*

**3. Creative Ideas**

*Alternative Titles:*
- The AI Brain That Never Forgets: Inside Claude-Mem
- Context is Currency: How Progressive Disclosure Saves 10x Tokens
- Curing "Context Rot" in AI Agents for Developers

*Twitter/X:*
- Tired of your AI coding assistant forgetting the architectural decisions you made yesterday? 🧠 Enter `claude-mem`: a persistent memory engine for Claude Code & Cursor that remembers your codebase without blowing up your API bill. #AI #DevTools #ClaudeCode
- Traditional RAG is wasting 94% of your LLM's attention budget! 🛑 `claude-mem` fixes this with "Progressive Disclosure" — giving AI an index first and letting it fetch details on-demand. Result: 10x token savings 💸

*LinkedIn post:* Headline — "Are you treating your LLM's context window like a junk drawer?" Body introduces context rot, presents the 3-layer Index/Timeline/Details workflow, notes 10x savings, closes with: *How are you currently managing context limits during long coding sessions with AI?*

---

### 5. Meeting Recording (adapted: project retrospective view)

> Act as a professional technical project secretary. Treating the changelog, issues, and architecture docs as if they were a running project meeting, create a summary in Markdown format with these sections: 1. Goal of the Project, 2. Main People / Components Who 'Spoke', 3. Summary of Main Discussions, 4. Important Decisions Made, 5. To-Do List / Action Items, 6. Unresolved Issues.

**Answer:**

**1. Goal of the Project**
Provide a seamless, persistent memory compression system for Claude Code that spans sessions. Auto-capture tool usage, compress semantically via the Claude Agent SDK, inject relevant context into future prompts. Treat context as finite currency.

**2. Main People / Components Who 'Spoke'**
- **Alex Newman (@thedotmack)** — creator, primary maintainer.
- **Community contributors**: @ousamabenyounes (API guards, session lifecycles), @bigph00t (Windows fixes, project naming), @Glucksberg (observer isolation), @jayvenn21, @rodboev (hook resilience), @dreamiurg (native module recovery).
- **Components that "spoke" most:** Lifecycle Hooks (5 stages), Worker Service (Express.js + Bun, port 37777), Claude Agent SDK + alternative providers (Gemini, OpenRouter), Hybrid DB layer (SQLite FTS5 + ChromaDB), MCP search tools (search / timeline / get_observations).

**3. Summary of Main Discussions**
- **Context pollution & progressive disclosure**: eliminate the 94% RAG waste by engineering an index-first 3-layer workflow for ~10x savings.
- **Battling artificial complexity & error masking**: multi-month effort deleted ~1,000 bloated lines and corrected 300+ error-handling anti-patterns (empty catches, giant try/catch blocks).
- **Cross-platform process stability**: PM2 + `better-sqlite3` unreliable on Windows; migrated to Bun + `bun:sqlite` to fix console popups, zombie `chroma-mcp`, and multi-GB RAM leaks.
- **Hook latency**: Stop hook blocked the CLI 3–7s per turn; community pushed refactor to fire-and-forget pattern.

**4. Important Decisions Made**
- **v7.1.0 migration** — PM2 → Bun `ProcessManager`; `better-sqlite3` → `bun:sqlite`.
- **Simplified MCP protocol** — 9 overlapping tools (~2,500 tokens) → 4 streamlined tools (~312 LOC), structurally enforcing progressive disclosure.
- **File Read Gate** — PreToolUse intercept on native Read; serve observation timeline instead of raw file.
- **Edge Processing for Privacy** — `<private>` tags stripped at hook level before serialization.
- **Idempotent Session Identity** — IDE `session_id` is source of truth; `INSERT OR IGNORE`.

**5. To-Do / Action Items**
- Adaptive Index Size, Relevance Scoring, Multi-Project Context, Collaborative Memory (roadmap).
- Process the massive "Sleep Agent Pipeline" PR #464 (+15,000 lines) — split or allocate dedicated review time.
- Issue #2037: GStack mode + per-project mode system via `.claude-mem.json`.
- Issue #2032: cooperative cycling + Storyline content ingestion engine.
- Issue #2038: branch-scoped memory via git ancestry filtering.
- Issue #2025: TITANS observer, Layer 3 transcript storage.

**6. Unresolved Issues**
- **#1941 (high)** — Linux worker with live-but-unhealthy PID blocks restart forever (`process.kill(pid, 0)` passes; stale PID file never removed; all MCP tools fail with `fetch failed`).
- **#1947 (high)** — OpenCode plugin defines `claude_mem_search` args as plain objects instead of Zod schemas; throws `schema._zod.def` TypeError and crashes OpenCode IDE on prompt submission.
- **Conflicting architecture PRs** — PR #700 (Windows Terminal Popup Fix), #722 (In-Process Worker Architecture), #657 (Generate/Clean CLI Commands) have merge conflicts; must be rebased in order.

---

### 6. Article Outline (SEO)

> Act as an SEO expert and content editor. Based on ALL the sources provided, do the following tasks: Part A: Competitor Analysis Summary — treating the claude-mem docs, the broader Claude Agent SDK, and ecosystem tools (Chroma, Bun, uv) as the competitive landscape, identify (a) Search Intent for someone looking for "persistent memory for Claude", (b) Common Topics they'll encounter, (c) Content Gaps that aren't well-covered. Part B: Create a Detailed Outline for a New Article titled "How to Add Real Memory to Claude Code in 10 Minutes", with title suggestions, headings, and writer notes grounded in what the sources actually document.

**Answer:**

**Part A — Competitor Analysis**

*Search Intent:* Developers / AI engineers hitting context-window exhaustion and context rot during long coding sessions. Intent is transactional + informational — want a plug-and-play solution that stops AI from forgetting architectural decisions, bug fixes, or workspace context. They're solving the O(N²) quadratic scaling problem where Claude re-synthesizes all prior tool outputs on every turn.

*Common Topics:*
- Progressive Disclosure + Token Economics (3-layer index→timeline→details).
- Hook-Based Architecture (SessionStart, PostToolUse, Stop).
- AI Providers & Cost (Gemini free tier 1,500 req/day, OpenRouter free models like `xiaomi/mimo-v2-flash:free`).
- Hybrid DB (SQLite FTS5 + ChromaDB).
- Process Management (Bun replacing PM2).

*Content Gaps:*
- **Non-developer / beginner onboarding** — docs are heavy on hooks and schemas, light on high-level narrative for users unfamiliar with AST parsing, Express, or vector DBs.
- **Provider cost-benefit analysis** — docs mention OpenRouter/Gemini savings but lack side-by-side comparisons of compression quality across providers.
- **Long-term workspace evolution** — little narrative on what a 3-month-old claude-mem database looks like for actual productivity.

**Part B — Article Outline: "How to Add Real Memory to Claude Code in 10 Minutes"**

*Title suggestions:*
- Stop Claude from Forgetting: A 10-Minute Guide to Persistent AI Memory
- Level Up Claude Code: Add Persistent Memory and Save Thousands of Tokens
- The Ultimate Guide to Claude-Mem: How to Give Your AI Agent a Brain

**H1: Introduction — The "Context Rot" Problem.** Hook on universal pain: every Claude Code session starts from scratch. Explain attention-budget depletion and O(N²) token scaling. Introduce claude-mem as the invisible fix.

**H2: What is Claude-Mem and How Does it Work?** Simplify architecture: background intercept of tool usage → AI worker compresses transcript into semantic observation → local SQLite/Chroma storage → quiet timeline injection at next session. Highlight Bun for fast cross-platform performance.

**H2: Step 1 — Installation & Prerequisites (3 min).** Primary command: `npx claude-mem install`. Requires Node 18+ and Claude Code; the installer handles Bun + uv dependencies.

**H2: Step 2 — Choose Your AI Provider for Memory Compression (2 min).** You don't need to burn the Claude API for background compression. Show Gemini free tier and OpenRouter free-model setup. Point to the Web Viewer UI at `http://localhost:37777` for toggling.

**H2: Step 3 — Progressive Disclosure & Memory Search (3 min).** Explain the 3-layer workflow as the secret weapon: (1) Search/Index — lightweight metadata scan, (2) Timeline/Context — chronological events around an issue, (3) Get Observations/Details — expensive full text only for validated items. Note the ~10x savings.

**H2: Advanced Features to Try Later (2 min).** Knowledge Agents (queryable "brain"), Folder Context Files (auto-generated CLAUDE.md per folder), Privacy Tags (`<private>` never persisted).

**H2: Conclusion.** Once installed, runs automatically; AI gets smarter without blowing up the API bill. CTA: visit `http://localhost:37777` during the next coding session.

---

### 7. Draft Feedback (360-Degree Review of claude-mem docs)

> Create a '360-Degree Feedback Report' for the claude-mem README and top-level documentation. Present the report in separate sections: Section 1: The Strict Editor's View — identify the weakest sentences, weak or missing arguments, places where claims aren't supported. Section 2: The New Reader's View — confusing jargon, parts that would bore or lose a first-time reader, missing onboarding context. Section 3: The Marketing Expert's View — intro strength, clarity of value proposition, whether the call-to-action is compelling, suggested rewrites for the hero section.

**Answer:**

**Section 1: The Strict Editor's View**
- **The crypto tangent undermines credibility.** *"$CMEM is a solana token created by a 3rd party without Claude-Mem's prior consent, but officially embraced by the creator"* at the bottom of the README feels unprofessional in a technical repo and weakens the authoritative engineering tone.
- **Unsupported claims around Endless Mode.** Docs promote it as a "biomimetic memory architecture" converting O(N²) → O(N), yet later admit these are based on *"theoretical modeling (not production measurements)"* and the feature is *"slower than standard mode."* Hyping with biology buzzwords while relying on unvalidated models weakens technical credibility.
- **"10x token savings" lacks immediate proof in the README.** The claim is mathematically supported much later (the 3-layer breakdown), but without an inline example a skeptical reader dismisses it as marketing fluff.

**Section 2: The New Reader's View**
- **Jargon overload in "How It Works."** A new user wants to know how the tool helps them code; instead the section throws MCP, Chroma Vector Database, FTS5, Bun, and Lifecycle Hooks before they understand the UX.
- **Installation fatigue.** Quick Start lists 5 install paths (npx, Gemini CLI, OpenCode, Marketplace, OpenClaw) consecutively before explaining how to *use* the tool. Reduce to one happy-path command; move the rest under "Other integrations."
- **Missing foundational context.** Docs assume the reader knows what Claude Code is. A standard web-UI Claude user has no bridge to the CLI / Agent SDK world.

**Section 3: The Marketing Expert's View**
- **Weak hero intro.** *"Persistent memory compression system built for Claude Code"* describes the mechanism, not the benefit.
- **Hidden gold.** The best line in the entire docs is buried in the Cursor Integration guide: *"Your AI stops forgetting. Give Cursor persistent memory."* — move this to the top of the README.
- **CTA analysis.** Just a code block (`npx claude-mem install`) with no framing. A strong CTA should emphasize zero-manual-intervention installation.

*Suggested hero rewrites:*
- **Benefit-driven:** *Your AI stops forgetting. `claude-mem` gives Claude Code persistent memory across all your sessions. It automatically captures your workflows, decisions, and codebase context so you never have to repeat yourself again.*
- **Action-oriented:** *Give Claude Code a long-term memory. Seamlessly preserve project context, reduce token costs by up to 10x, and keep your AI agent perfectly synced with your codebase across restarts — all automatically in the background.*

---

### 8. Study Guide

> Act as a dedicated tutor. Based on all the study materials provided for the topic of "claude-mem — a persistent memory system for Claude Code", create a 'Complete Study Guide Kit' including: 1. Summary of Key Concepts (hooks, progressive disclosure, File Read Gate, Chroma + SQLite hybrid, Bun worker, MCP tools, privacy tags), 2. Terminology Flashcards (front = term, back = plain-English definition + why it matters), 3. Practice Questions (both essay-style and multiple-choice), 4. Answer Key.

**Answer:**

**1. Summary of Key Concepts**
- **Hooks** — 5-stage lifecycle (SessionStart, UserPromptSubmit, PostToolUse, Stop, SessionEnd) observing Claude Code externally.
- **Progressive Disclosure** — 3-layer memory injection (Index → Timeline → Details) respecting the AI's attention budget.
- **File Read Gate** — PreToolUse intercept; serves a ~370-token timeline instead of a full file (75–97% savings).
- **Chroma + SQLite Hybrid** — SQLite FTS5 for keyword speed, ChromaDB for semantic vectors, graceful fallback to SQLite-only if Chroma is down.
- **Bun Worker** — Express.js + Bun on port 37777; fire-and-forget async compression via Claude Agent SDK so IDE never blocks.
- **MCP Tools** — 4 tools (`search`, `timeline`, `get_observations`, `__IMPORTANT`) structurally enforcing progressive disclosure.
- **Privacy Tags** — `<private>...</private>` stripped at the hook edge; never written to disk.

**2. Terminology Flashcards**
- **Context Rot** — degradation of AI accuracy as context fills; why: context is finite, dumping wastes budget.
- **O(N²) Complexity Problem** — exponential cost of re-synthesizing all prior tool outputs each turn; why: forces session abandonment. Endless Mode targets O(N).
- **Smart Explore** — tree-sitter AST-based structural search; why: up to 12x cheaper than Glob→Grep→Read cycles.
- **Edge Processing (Tag Stripping)** — remove `<private>` content at the hook level; why: sensitive data never serialized or persisted.

**3. Practice Questions**

*MC:*
1. Which describes the 3-Layer Workflow? A) Read→Edit→Write, B) SQLite→Chroma→Local, C) Search→Timeline→Get Observations, D) SessionStart→PostToolUse→SessionEnd.
2. Primary purpose of the Bun worker? A) Replace Claude Code CLI, B) Async background processor for compression so coding session isn't blocked, C) GUI, D) Disable MCP on rate limits.

*Essay:*
3. Explain how the File Read Gate uses Progressive Disclosure and why it matters for the attention budget.

**4. Answer Key**
1. **C.** The index→timeline→details pattern yields ~10x savings.
2. **B.** Semantic compression takes 5–30s; hooks enqueue and return; Bun worker processes async.
3. Key points: gate intercepts a full-file read and substitutes lightweight metadata; the agent makes cost/benefit decisions (semantic priming ~0 tokens, specific observations ~300, full read 5–50k); 75–97% attention-budget savings leaves more room for reasoning.

---

### 9. Interview Prep (adapted: senior platform engineer portfolio dive)

> Act as an engineering career coach. I'm interviewing for a senior platform engineer role and want to use claude-mem as my portfolio deep-dive topic. Based on all the sources, create a detailed 'Interview Prep Plan' with: Part 1: Analyzing Your Fit, Part 2: Your Answer Script (90-sec intro + 3 STAR stories), Part 3: Questions to Ask the Interviewer.

**Answer:**

**Part 1 — Fit**
1. **Process Management & Resource Isolation** — migrated worker from PM2 to a custom Bun `ProcessManager` with PID file tracking, port management, cross-platform POSIX/Windows signal handling. Proves you build self-managing daemons that don't leak resources.
2. **System Resilience & Graceful Degradation** — 5-hook architecture on non-blocking fire-and-forget HTTP with 2-second timeouts; worker crashes fail-open without breaking primary Claude Code UX.
3. **Cost Optimization & Distributed Economics** — O(N²) → 3-layer progressive disclosure workflow for ~10x token reduction. Proves you design API layers that optimize expensive downstream compute.

**Part 2 — Answer Script**

*90-second intro:* *"I'm a platform engineer focused on building resilient, scalable backend infrastructure. Most recently, I architected claude-mem, a persistent memory and background-processing engine for AI coding agents. To make it work, I had to solve complex distributed systems problems: tracking distributed state across different IDE lifecycles, managing background daemon concurrency, and preventing resource leaks. I built a highly decoupled, event-driven architecture using Node and Bun that processes heavy workloads entirely out of the user's critical path. I'm particularly proud of how I engineered the system for graceful degradation — ensuring that even under severe worker crashes or vector database spawn storms, the primary application never hangs. I'm looking for a senior platform role where I can bring this expertise in process isolation, reliability, and cost-efficient architecture to scale your core infrastructure."*

*STAR 1 — Resource Exhaustion & Zombie Processes.* **S:** SDK agent spawning long-running subprocesses; sessions ending without cleanup produced 155 orphaned processes consuming 51GB RAM. **T:** Guarantee subprocess lifecycle regardless of session exit mode. **A:** Built a `ProcessRegistry` to track PIDs; added graceful shutdown with 5-second SIGTERM grace then SIGKILL; defense-in-depth "orphan reaper" every 5 minutes. **R:** Eliminated multi-GB leaks and process accumulation.

*STAR 2 — Concurrency Failures (the Spawn Storm).* **S:** 640+ `chroma-mcp` processes spawned in 5 minutes consuming 75% CPU / 64GB virtual memory under concurrent observation events. **T:** Stabilize vector DB connection layer under high concurrency. **A:** 5-layer defense: connection mutex via promise memoization; count-based process guard; circuit breaker with 60-second cooldown after 3 consecutive failures. **R:** Stopped the error-driven reconnect loop; stable CPU/memory under load.

*STAR 3 — Unblocking the Critical Path.* **S:** Stop hook executing synchronously blocked the CLI 3–7 seconds per conversational turn, making IDE integrations feel frozen. **T:** Remove latency from the critical path while preserving eventual consistency. **A:** Refactored hooks to strict fire-and-forget: enqueue via HTTP POST, return immediately; Bun worker handles compression and storage async. **R:** Sub-100ms conversational responsiveness; DB eventually consistent in the background.

**Part 3 — Questions to Ask**
1. *On graceful degradation:* "In claude-mem I designed fire-and-forget hooks so if the background memory daemon crashed, the primary application would seamlessly fail open. How does your platform handle failure isolation between core user-facing services and heavy background processing?"
2. *On scaling API/compute costs:* "To solve O(N²) context loading costs I built a 3-layer progressive disclosure workflow that deferred heavy API fetches until explicitly needed, reducing token consumption by 10x. What are the biggest cost-scaling or resource bottleneck challenges your platform is facing today?"
3. *On process & state management:* "Managing local infrastructure meant custom process registries, orphan reapers, and strict idempotency keys for distributed session IDs. What does the observability and state-consistency story look like for your distributed microservices?"
