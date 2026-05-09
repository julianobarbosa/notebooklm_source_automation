# Project: notebooklm_source_automation

## NotebookLM language rule (non-negotiable)

**All NotebookLM operations executed inside this project MUST run in `pt-BR`.**

This applies to:

- Every question phrased to a notebook via `notebooklm ask` (or any equivalent skill/MCP/script).
- Every `notebooklm configure --persona` set on a notebook touched by this project.
- Every report, synthesis, or note saved back into a NotebookLM notebook from this project.
- Every artifact generated _from_ a NotebookLM response (audio overview, mind map, quiz, slides, infographic, video, study guide, etc.).

The rule covers Claude's calls AND any user-asked direct CLI run inside this project — if a CLI invocation would produce English NotebookLM output, prepend the pt-BR directive instead of running it as-is.

### How to apply (in priority order)

1. **Persona-bound (preferred, durable):** When activating a notebook for project work, set the persona once:

   ```bash
   notebooklm configure --persona 'Responda SEMPRE em português brasileiro (pt-BR). Use terminologia técnica em português; deixe siglas/protocolos/comandos em inglês quando o termo técnico for o original (ex.: "Wi-Fi 6", "WPA3", "DFS", "OpenWrt", "iptables"). Citações inline [1], [2] permanecem como estão. Não traduza nomes próprios, nomes de produto, nem trechos de código/CLI/JSON/YAML.'
   ```

   This binds pt-BR to the notebook's chat config, so any agent or tool that queries it inherits the language.

2. **Per-question fallback:** If a notebook does not yet have the persona set, prepend the directive to every question:

   > `Responda em pt-BR. <pergunta original>`

3. **Synthesis / report writing:** Any markdown synthesized from notebook output (Q1–Qn reports, summaries, etc.) must be written in pt-BR. Verbatim quotes from a notebook stay verbatim — do not back-translate cited Gemini text. Surrounding analysis, headings, verdict labels (`[NÃO VERIFICADO]` instead of `[UNVERIFIED]`), and recommendations are pt-BR.

### What stays in English

- File paths, command names, flag names, code blocks, JSON/YAML keys.
- Source URLs and source titles (don't rename a Manua.ls page just because it ended up in pt-BR space).
- Citation markers (`[1]`, `[2]`).
- Protocol names and standardized acronyms (WPA3, PMF, DFS, MU-MIMO, OFDMA, 802.11k/v/r, OpenWrt, MiWiFi, OneMesh).

### Why

This project's NotebookLM library is consumed by Brazilian-Portuguese readers. Mixing English Gemini responses into pt-BR reports forces re-translation downstream and breaks the "single source of truth" model. Lock the language at the persona layer and the rule propagates without per-call gymnastics.

---

## NotebookLM research-depth rule (non-negotiable)

**Every `notebooklm source add-research` invocation in this project MUST pass `--mode deep`.**

The CLI's default is `--mode fast` (a quick web pass that under-samples sources). For this project, the pre-configured default is `deep`:

```bash
# Correct
notebooklm source add-research "<query in pt-BR>" --mode deep

# Wrong (uses CLI default 'fast')
notebooklm source add-research "<query>"
```

### When `fast` is acceptable (require explicit reason)

Use `--mode fast` only when ALL of these hold, and state the reason in the same update:

- Exploratory probe before a real run (sanity check, sniff test).
- Query is narrow and the goal is one or two top-result snippets, not coverage.
- Time/cost constrained and the depth/quality tradeoff is intentional.

In every other case, use `--mode deep`. If unsure, default to `deep`.

### Combining with `--import-all`

`--import-all` auto-imports every result. Only combine `--mode deep --import-all` when the query is tightly scoped (a specific product, a specific failure mode, a specific document set). For broad queries, run without `--import-all` first, review the result list, then import selectively — auto-importing 20 mediocre results into the notebook hurts the next `ask` more than it helps.

---

## Community-forum research rule (non-negotiable)

**Any research, scraping, or data extraction targeting community forums in this project MUST go through the `Apify` skill.**

In-scope platforms (current):

- **Reddit** (`reddit.com`, `old.reddit.com`, `redd.it`)
- **Quora** (`quora.com`)
- **Slack** public archives (`slack.com`, `app.slack.com`)
- **Google Groups** (`groups.google.com`)
- **Instagram** (`instagram.com`)
- **Facebook** (`facebook.com`, `fb.com`, `m.facebook.com`)
- **X / Twitter** (`x.com`, `twitter.com`, `t.co`)
- **Discord** public servers (`discord.com`, `discord.gg`) — same family of bot-hostile channels, included for completeness

### Why

These platforms are rate-limited, paywalled, login-walled, or hostile to bare `curl`/`wget`/`WebFetch`. We learned this the hard way during the 2026-05-05 Azure FinOps KPI research run: Reddit / Slack / Discord / Quora were invisible to direct fetch tools, the report had to disclose the gap, and the missing community signal was exactly where the highest-value practitioner debate lives. **The Apify skill exists to close that gap** — actor-based scrapers, auth, rate-limit backoff, pagination, and CAPTCHA escalation are already handled.

### How to apply (in priority order)

1. **Skill-bound (preferred):** Invoke the Apify skill directly so it can route to the correct actor with the right input shape:

   ```
   Skill('Apify')
   ```

2. **Apify CLI fallback:** If you already know the actor and need a single call, use the CLI:

   ```bash
   apify call <actor-id> --input '<json>'
   ```

3. **Recommended actors per platform** (pre-vetted; the skill SKILL.md is authoritative):

   | Platform         | Actor                                                          |
   | ---------------- | -------------------------------------------------------------- |
   | Reddit           | `trudax/reddit-scraper-lite`, `dtrungtin/reddit-scraper`       |
   | Quora            | `apify/quora-scraper`                                          |
   | Slack (public)   | `apify/slack-channel-scraper`                                  |
   | Google Groups    | `apify/google-groups-scraper`                                  |
   | Instagram        | `apify/instagram-scraper`                                      |
   | Facebook         | `apify/facebook-pages-scraper`, `apify/facebook-posts-scraper` |
   | X / Twitter      | `apidojo/tweet-scraper`, `apify/twitter-scraper`               |
   | Discord (public) | `eedm123/discord-scraper`                                      |

### When direct fetch is acceptable (require explicit reason)

Use `WebFetch` / `curl` / `wget` against an in-scope host **only** when ALL of these hold, and state the reason in the same update:

- One-shot fetch of a **single public URL the user explicitly pasted** — not bulk discovery, not enumeration, not pagination.
- The page is known to be public-without-auth (e.g., a single archived Reddit post indexed by Google).
- You are diagnosing a hook or testing connectivity and will not act on the output as research data.

In every other case, use the Apify skill. If unsure, default to Apify.

### Synthesis hygiene (anti-fabrication)

When community-forum data flows into a research synthesis, the same rules from Rule 1 apply: **verbatim quotes preserved in original language**, every URL `WebFetch`-validated to resolve, every claim of "this practitioner said X" tied to a specific Apify-extracted comment with handle + permalink. **Never paraphrase a community comment as if quoting it.** If Apify runs but returns thin coverage, disclose the gap honestly — the FinOps KPI run's "Lacunas honestas" section is the canonical pattern.

### What stays out of Apify

- Direct fetches of **product documentation pages** (Microsoft Learn, AWS Docs, FinOps Foundation framework) — those are not community forums; use `WebFetch` / `microsoft_docs_fetch` / `context7` / `chrome`.
- **GitHub repositories and issues** — use `gh` CLI / `WebFetch`. (Discussions on individual repos are a grey area; if you're enumerating issue/PR comments at scale, route through Apify only if a dedicated GitHub actor is justified — usually `gh` is faster.)
- **Stack Overflow / Stack Exchange** — use the official Stack Exchange API (`api.stackexchange.com`); it's free and unrestricted.
- **Hacker News** — use the Algolia API (`hn.algolia.com/api/v1/search`); also free and unrestricted.

---

## Library & SDK documentation rule (non-negotiable)

**Any lookup of library, framework, SDK, CLI, API, or cloud-service documentation in this project MUST go through Context7 first.**

The CLI surface this project orchestrates (`notebooklm-py`, `apify-client`, `python-fabric`, Terraform providers, Azure SDKs, Python data libs) evolves faster than model training data. Guessing API shape from memory has burned us before — wrong flag names, deprecated parameters, hallucinated method signatures. Context7 returns version-current docs straight from the upstream source, and the cost of one extra MCP call is zero compared to debugging a fabricated invocation.

### How to apply (in priority order)

1. **Context7 (preferred):** Use the MCP server before writing code that touches any external library/CLI/API.

   - **Workflow:** call `resolve-library-id` with the library name → call `query-docs` with the returned ID and a focused topic.
   - Both server flavors are wired in this environment and behave identically — pick whichever resolves the library:
     - `mcp__claude_ai_Context7__resolve-library-id` + `mcp__claude_ai_Context7__query-docs`
     - `mcp__plugin_context7_context7__resolve-library-id` + `mcp__plugin_context7_context7__query-docs`
   - Use Context7 even when you think you know the answer — flags rename, defaults flip, methods get deprecated.

2. **Microsoft / Azure docs (specialized fallback):** For Microsoft technologies (Azure services, .NET, M365, Power Platform), prefer `mcp__plugin_microsoft-docs_microsoft-learn__microsoft_docs_search` / `microsoft_docs_fetch` / `microsoft_code_sample_search` — they index Microsoft Learn directly with higher fidelity than Context7 for that surface.

3. **`WebFetch` (last-resort fallback):** Use only when Context7 returns no hit AND no specialized server covers the topic. State the reason in the same update ("Context7 had no entry for `<library>`; falling back to upstream docs URL").

### In-scope examples (always Context7)

- `notebooklm-py` itself — the CLI we drive every day; signatures and flags evolve between releases.
- `apify-client` (Python and JS) — Rule 3's primary skill calls this directly.
- Terraform providers (`hashicorp/azurerm`, `hashicorp/azuread`, etc.) — provider schemas drift across versions.
- Python libs that show up in pipelines: `httpx`, `pydantic`, `tenacity`, `rich`, `typer`, `click`, `pandas`.
- Azure SDKs (`azure-mgmt-*`, `azure-identity`, `azure-storage-blob`).
- `gh` CLI subcommands and flags.

### When Context7 is not appropriate

Per the upstream MCP server description, do NOT route these through Context7 (use the appropriate alternative):

- **Refactoring code already in this repo** — read the code; don't ask docs about our own logic.
- **Writing scripts from scratch with no external library** — pure stdlib / pure logic doesn't need docs.
- **Debugging business logic specific to this project** — read the code, run it, instrument it.
- **General programming concepts** (algorithms, design patterns, language syntax basics) — model knowledge is fine.
- **Code review** — read the diff and the surrounding code.
- **Community discussion / opinions / war stories** — Rule 3 (Apify for forums) or Stack Exchange API.
- **NotebookLM responses about our notebook contents** — Rule 1 (`notebooklm ask`), not Context7.

### Synthesis hygiene

When Context7 output flows into a synthesis or report:

- Cite the library name + version returned by `resolve-library-id` (e.g., "per `notebooklm-py` v0.3.4 docs").
- Quote the relevant snippet verbatim — same anti-fabrication discipline as Rules 1 and 3.
- If Context7 returns thin / stale coverage for a topic, disclose the gap honestly and fall through to step 3.

### Why

We've shipped wrong code from confidently-recalled API shapes more than once. Context7 is the cheapest insurance against that failure mode in a project whose entire purpose is wrapping evolving CLIs (NotebookLM, Apify, future ones). Lock the lookup at the MCP layer and the rule propagates without per-call gymnastics, exactly mirroring Rules 1–3.

---

## Enforcement layer

All four rules above are enforced at three layers:

| Layer       | Mechanism                                                                                                                                                | Scope                                                                                                |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Instruction | This `CLAUDE.md` (loaded by Claude on session start in this project)                                                                                     | Every Claude session opened in this directory                                                        |
| Service     | `notebooklm configure --persona` (Rule 1) · `Apify` skill actor catalog (Rule 3) · Context7 MCP server (Rule 4)                                          | Per-notebook (durable) for Rule 1; per-platform actor binding for Rule 3; per-library lookup for Rule 4 |
| Harness     | `PreToolUse` hooks in `.claude/settings.json`: `notebooklm-ptbr-rule.sh` (Rules 1 + 2) and `community-forum-apify-rule.sh` (Rule 3)                      | Every Bash call from this project — fires deterministically regardless of model                      |

The harness layer is the deterministic enforcer. The hook scripts live at:

- `.claude/hooks/notebooklm-ptbr-rule.sh` — fires on `Bash(notebooklm *)`, injects Rules 1 + 2.
- `.claude/hooks/community-forum-apify-rule.sh` — fires on every `Bash` call, fast-bails when the command does not touch an in-scope community-forum host, and otherwise injects Rule 3.
- _(no harness hook for Rule 4 yet — Context7 lookups are MCP calls, not Bash, so a `PreToolUse` Bash hook can't intercept them. If we want deterministic enforcement, the path is a `UserPromptSubmit` hook that detects "looking up library X" intent and injects a reminder. Tracked as a follow-up; instruction layer is sufficient for now.)_
