# Plan: Generate All NotebookLM Artifacts for casey/just Notebook

## Context

The `casey/just — Command Runner` NotebookLM (id `c0bbb7d0-24ca-4848-ade5-c16aaffe4ba5`) was created in the previous turn with 7 curated sources covering the manual, README, changelog, contributing guide, grammar spec, and the repo's own justfile. The user now wants every Summary item generated — the complete set of NotebookLM artifacts ("Studio" outputs).

`studio_status` confirms zero artifacts currently exist, so this is a clean generation run with no duplicates to reconcile.

## Artifacts to Generate (9 total)

All generated against ALL sources (default `source_ids=null`) since the seven sources were curated to cover the repo entirely.

| # | Artifact | Tool | Params |
|---|----------|------|--------|
| 1 | Audio Overview (podcast) | `audio_overview_create` | `format="deep_dive"`, `length="default"`, `language="en"`, `confirm=true` |
| 2 | Video Overview | `video_overview_create` | `format="explainer"`, `visual_style="auto_select"`, `language="en"`, `confirm=true` |
| 3 | Mind Map | `mind_map_create` | `title="just — Command Runner"`, `confirm=true` |
| 4 | Slide Deck | `slide_deck_create` | `format="detailed_deck"`, `length="default"`, `language="en"`, `confirm=true` |
| 5 | Report — Briefing Doc | `report_create` | `report_format="Briefing Doc"`, `language="en"`, `confirm=true` |
| 6 | Report — Study Guide | `report_create` | `report_format="Study Guide"`, `language="en"`, `confirm=true` |
| 7 | Flashcards | `flashcards_create` | `difficulty="medium"`, `confirm=true` |
| 8 | Quiz | `quiz_create` | `question_count=10`, `difficulty="medium"`, `confirm=true` |
| 9 | Infographic | `infographic_create` | `orientation="landscape"`, `detail_level="standard"`, `language="en"`, `confirm=true` |

**Data Table is intentionally excluded** — it requires a `description` argument (what structured data to tabulate), and `just`'s documentation does not naturally contain tabular datasets. Forcing one would produce low-value output. If the user wants one, they can specify a description (e.g., "table of all settings with defaults and descriptions").

## Execution Strategy

1. **Kick off all 9 artifacts in parallel** — each `*_create` call with `confirm=true` is a fire-and-forget job. NotebookLM queues and generates them server-side; no need to wait sequentially.
2. **Poll `studio_status` once after ~60s** to confirm jobs are queued/in-progress (not to wait for completion — audio/video can take 5-15 minutes).
3. **Return the notebook URL** so the user can watch artifacts appear in the NotebookLM Studio panel as they complete.

## Critical Files / Tools

- **MCP tool suite**: `mcp__notebooklm-rpc__*` (already authenticated from previous turn — no re-auth needed).
- **PRD**: `MEMORY/WORK/20260420-notebooklm-just-repo/PRD.md` — update with the artifact generation run (new ISC block) or create a new PRD slug. Preference: new PRD since this is a distinct task (generation vs. sourcing).

## Verification

1. Each `*_create` call returns `status: success` with a job/artifact ID.
2. `studio_status` after submission shows `summary.in_progress >= 9` or `summary.total == 9`.
3. Notebook URL shows all 9 artifact tiles in the Studio panel:
   `https://notebooklm.google.com/notebook/c0bbb7d0-24ca-4848-ade5-c16aaffe4ba5`
4. A final `studio_status` check near session end confirms completion rate (audio/video may still be in progress — that's expected, not a failure).

## Risks & Mitigations

- **Auth drift**: If any call returns 401, run `notebooklm-mcp-auth` and retry. Not expected — auth was valid moments ago.
- **Rate limiting**: If parallel submission trips a limit, fall back to sequential submission with 2s spacing.
- **Generation failure for a specific artifact**: Report the failure, retry once, then surface remaining failures to the user.
- **Long-running audio/video**: These are async — don't block the session waiting for completion. User polls Studio UI or asks us to re-check with `studio_status`.
