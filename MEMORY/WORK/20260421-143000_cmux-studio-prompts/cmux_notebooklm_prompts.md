# cmux :: docs — 9 Curated NotebookLM Prompts

Adapted for the `cmux :: docs` notebook (ID `e0ed6d5f-abdc-4957-9ccd-fd988f88970f`).

Topic: **cmux** by manaflow-ai — native macOS terminal built on libghostty for running parallel AI coding agents (Claude Code, Codex, OpenCode). YC S24, launched Feb 19, 2026, ~15k stars by Apr 2026. AGPL-3.0.

Sources:
- Prompts 1–3 adapted from XDA Developers: https://www.xda-developers.com/prompts-i-use-to-get-most-out-of-noteboooklm/
- Prompts 4–9 adapted from AI Fire: https://www.aifire.co/p/6-notebooklm-prompts-that-do-your-hard-work-for-you

Paste any prompt into the NotebookLM chat panel for the `cmux :: docs` notebook.

---

## Prompt 1 — Five Essential Questions about cmux
*(Source: XDA #1 — Study Questions)*

```
1.) Analyze all sources in this notebook about cmux (manaflow-ai) and generate 5 essential questions that, when answered, capture the main points and core meaning of the material.
2.) When formulating your questions:
   a. Address the central theme — cmux as a "primitive, not a solution" terminal for AI coding agents
   b. Identify key supporting ideas (libghostty rendering, notification rings, Ghostty config reuse, scriptable CLI/socket API, claude-teams, remote workspaces)
   c. Highlight important facts or evidence (YC S24, launched Feb 19 2026, ~15k stars, #2 on HN, Mitchell Hashimoto endorsement)
   d. Reveal the founders' purpose or perspective (Austin Wang + Lawrence Chen — parallel-agent pain point with generic notifications)
   e. Explore significant implications — why cmux is a terminal *substrate*, not an orchestrator, and what that means for the AI-coding tool layering (board → orchestrator → review → terminal → agent)
3.) Answer all 5 questions one-by-one in detail, citing specific sources from the notebook.
```

---

## Prompt 2 — Find the Interesting Bits about cmux
*(Source: XDA #2 — Surprising Insights)*

```
What are the most surprising or interesting pieces of information or narratives in these sources about cmux? Focus on:
- Counter-intuitive design decisions (e.g., "primitive, not a solution")
- Verbatim quotes from the founders, Mitchell Hashimoto, or Hacker News commenters
- Unexpected community dynamics (founder responsiveness, nightly releases, ecosystem spawning)
- Technical choices that differ from conventional wisdom (native Swift vs Electron, no live session restore)
- Quotable lines that capture cmux's identity

Include at least 8 key quotes with attribution.
```

---

## Prompt 3 — Quiz Show on cmux Architecture
*(Source: XDA #3 — Gamified Quiz)*

```
You're hosting a fun quiz show with two hosts. The first host quizzes the second on concepts from this notebook about cmux by manaflow-ai. Include a mix of multiple choice and true/false questions covering: libghostty rendering, OSC notification protocols (OSC 9/99/777), the cmux claude-teams command, Ghostty config compatibility, vertical tabs and notification rings, remote workspaces and browser routing, AGPL licensing, and the cmux-vs-tmux-vs-orchestrator layering model.

Occasionally, the second host should get an answer wrong, and the first host should step in to explain the correct answer in a clear and concise way, quoting the sources. At the end, share the final score and a brief summary of how the second host did.
```

---

## Prompt 4 — cmux Content Analyst Report
*(Source: AI Fire #1 — Content Analyst)*

```
Act as a content strategy expert. Based on the sources in this notebook about cmux (manaflow-ai), create a full analysis with the following structure:

**1. Quick Summary:**
   - Give 3 bullet points that summarize the most important ideas about cmux.

**2. Deep Analysis:**
   - **Target Audience:** Who is cmux for? (Be specific — which developers, at what workflow scale, on which OS.)
   - **Main Arguments:** List the 3 main arguments cmux makes about terminal design for AI agents.
   - **Best Quotes:** Find 3 powerful sentences or facts from the sources that can be used as quotes (include attribution).

**3. Creative Ideas:**
   - **Alternative Taglines:** Suggest 2 other taglines for cmux besides "The terminal built for multitasking." One should make developers curious; one should focus on concrete benefits.
   - **Social Media Content:** Write a short LinkedIn post and a tweet/X post promoting cmux to AI-coding engineers, including good hashtags.
```

---

## Prompt 5 — cmux Release/Dev Meeting → Action Plan
*(Source: AI Fire #2 — Meeting to Action Plan)*

```
Act as a professional project secretary. Based on the GitHub Discussions, Hacker News threads, and Reddit feedback in this notebook, treat the collective community conversation as if it were a cmux product meeting. Create a meeting summary in Markdown format with these sections:

**1. Goal of the Meeting:**
   - In one sentence, what is the community collectively asking cmux to solve next?

**2. Main Voices:**
   - List the key people who spoke (e.g., lawrencecchen, Mitchell Hashimoto, HN commenters like @pupppet, @trevyn, @twostorytower; Reddit users like @afruth, @pavelanni).

**3. Summary of Main Discussions:**
   - Summarize the main topics discussed across threads (session persistence, docs gap, Linux/Windows ports, theming, MCP integrations, sidebar grouping, etc.).

**4. Important Decisions Made:**
   - List the concrete decisions or commitments the maintainers announced (e.g., bug fixes shipped within 24h on launch day, nightly build cadence).

**5. To-Do List (Action Items):**
   - Create a table with 3 columns: "Task," "Likely Owner," and "Priority." List the concrete improvements requested by the community.

**6. Unresolved Issues:**
   - Write down questions or problems that are not yet solved (session restore of live PTYs, Linux/Windows support, license concerns, documentation gaps).
```

---

## Prompt 6 — SEO Outline: "Ultimate Guide to cmux"
*(Source: AI Fire #3 — SEO Outline Builder)*

```
Act as an SEO expert and content editor specializing in developer tools. Based on ALL the sources in this notebook about cmux, do the following:

**Part A: Competitor & Landscape Analysis**
1. **Search Intent:** When developers search "cmux", "terminal for Claude Code", or "parallel AI agents macOS", what do they actually want to know? (Are they evaluating, installing, comparing, or troubleshooting?)
2. **Common Topics:** List 5 sub-topics every cmux article or HN thread covers (installation, notification rings, Ghostty compatibility, claude-teams, comparison to tmux, etc.).
3. **Content Gaps:** Based on the sources, what important cmux topics are under-covered? (E.g., advanced cmux.json recipes, cmux-resurrect workflow, socket API scripting, MCP integration patterns, enterprise AGPL concerns.)

**Part B: Create a Detailed Outline for a New Article**
Using Part A, produce a detailed outline for a new article that can outrank existing cmux coverage. Include:
1. **3 interesting H1 Title suggestions** (one curiosity-driven, one benefit-driven, one authority-driven).
2. **Full H2/H3 structure** in logical flow, including at least one section that fills the content gaps from Part A.
3. **Writer notes** under each heading: specific facts, quotes, or data points from the notebook to include.
```

---

## Prompt 7 — 360° Feedback on the cmux README / Marketing
*(Source: AI Fire #4 — Writing Feedback Report)*

```
Create a "360-Degree Feedback Report" for the cmux GitHub README and cmux.dev homepage content captured in this notebook. Present the report in separate sections, each from the viewpoint of a different role:

**Section 1: The Strict Editor's View**
   - Point out the 3 longest or weakest sentences in the README/homepage copy and suggest shorter, clearer rewrites.
   - Which claim or argument in the cmux positioning ("primitive, not a solution", "not an orchestrator") is the weakest or needs more proof?

**Section 2: The New Developer's View**
   - List any terms or concepts that might confuse a developer new to AI coding agents or Ghostty (e.g., OSC 9/99/777, libghostty, claude-teams, worktrees).
   - Which part of the current cmux messaging is the most boring or would make a new reader stop? Why?

**Section 3: The Developer-Marketing Expert's View**
   - Is the cmux.dev homepage hook interesting enough? If not, rewrite an alternative opening.
   - Suggest a stronger call-to-action for the end of the README (beyond "brew install …").
```

---

## Prompt 8 — Complete cmux Study Guide Kit
*(Source: AI Fire #5 — Study Guide Generator)*

```
Act as a dedicated tutor for a developer onboarding to cmux. Based on all the sources in this notebook, create a "Complete cmux Study Guide Kit" with these parts:

**1. Summary of Key Concepts:**
   - Explain the 5 most important ideas in cmux (workspaces & vertical tabs, notification rings & OSC protocol, Ghostty config reuse, claude-teams mode, remote ssh workspaces with browser routing). Explain each simply and give a specific example from the sources.

**2. Terminology Flashcards:**
   - Create a list of 12 important cmux/terminal-adjacent terms and short definitions (libghostty, OSC 9/99/777, claude-teams, worktree, cmux.json, cmux notify, AGPL-3.0, sidebar ring, session restore, primitive-not-solution, scriptable socket API, agent-browser). Present as "Term: Definition."

**3. Practice Questions:**
   - Write 5 essay-style questions covering cmux architecture, philosophy, comparison, limitations, and extensibility.
   - Write a 10-question multiple-choice quiz (A, B, C, D) testing knowledge of cmux installation, features, command syntax, and reception facts.

**4. Provide an Answer Key:**
   - At the very end, provide the answers for the 10 MCQs with one-sentence rationale each, citing sources.
```

---

## Prompt 9 — Conference Talk Script: "Why I Ship cmux"
*(Source: AI Fire #6 — Interview Script → adapted as conference-talk script)*

```
Act as a developer-advocate coach. I'm preparing to give a 15-minute conference talk about cmux at a developer conference, positioned as a Manaflow engineer or power user. Based on all the sources in this notebook, create a detailed "Talk Prep Plan":

**Part 1: Audience Fit Analysis**
   - List the 3 biggest matches between cmux's design choices and the pains that developers running parallel AI agents actually have (as evidenced by HN comments, Reddit threads, and GitHub discussions).

**Part 2: Your Talk Script**
   - Write a 3–4 sentence opening hook for the talk that names the specific pain ("Claude is waiting for your input") and pivots to the cmux answer.
   - Suggest 3 "story moments" from the sources to anchor the talk. Present each in the STAR format (Situation, Task, Action, Result). Examples: Mitchell Hashimoto's public endorsement; 18 releases in 2 days post-launch; community building cmux-resurrect to fill the session-persistence gap.

**Part 3: Audience Q&A Prep**
   - Suggest 3 smart questions the audience is likely to ask (session persistence, Linux/Windows, AGPL licensing) and draft grounded answers using direct quotes from the sources.
```

---

## Attribution

- Prompts 1–3 adapted from Alex Blake's article on XDA Developers: "3 prompts I use to get the most out of NotebookLM" — https://www.xda-developers.com/prompts-i-use-to-get-most-out-of-noteboooklm/
- Prompts 4–9 adapted from AI Fire: "6 NotebookLM Prompts That Do Your Hard Work For You" — https://www.aifire.co/p/6-notebooklm-prompts-that-do-your-hard-work-for-you

Original prompts are generic templates; these versions are rewritten to reference cmux-specific facts, actors, and sources so that NotebookLM's grounding stays tight.
