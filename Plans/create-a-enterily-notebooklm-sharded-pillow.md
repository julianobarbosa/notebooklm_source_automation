# Plan: Create NotebookLM "claude-mem :: docs" from thedotmack/claude-mem

## Context

Build a comprehensive NotebookLM notebook covering the [claude-mem](https://github.com/thedotmack/claude-mem) project — a persistent memory compression system for Claude (63.9k stars, TypeScript, Node.js/Bun). The goal is an "entire" knowledge base combining the full docs site (`docs.claude-mem.ai`), key repo files, and community/ecosystem sources so the notebook can answer architecture, usage, configuration, and integration questions end-to-end.

**Scope approved:** "Everything + community (~60–80 sources)."
**Title approved:** `claude-mem :: docs`.

## Approach: MCP API (`notebooklm-rpc`)

Use `mcp__notebooklm-rpc__*` tools directly — no Playwright, no CSV. Mirrors the successful pattern from `Plans/modular-whistling-snail.md` (MemPalace notebook) and the AKS NAP notebook (project memory `project_aks_nap_notebook.md`). This is preferred per project memory: `project_overview.md` notes the MCP approach "may be preferred over browser automation for new workflows."

## Critical files to reuse / reference

- `Plans/modular-whistling-snail.md` — template for MCP-based notebook builds, including the GitHub-URL-fallback-to-text pattern.
- Memory `feedback_medium_urls_fail.md` — skip any Medium.com URLs.
- Memory `feedback_notebooklm_dedup_workflow.md` — post-build cleanup workflow (dedup by URL, delete status-3 failures, parallel batches of 10).

No edits to `main.py`, `functions/links.py`, or CSVs — those are for the Playwright flow, not needed here.

## Source Inventory (~72 sources, well under the 300 cap)

### A. Primary entry points (2)
- `https://github.com/thedotmack/claude-mem` (repo root)
- `https://docs.claude-mem.ai/` (docs home)

### B. Docs site — full sweep from `llms.txt` (35 URLs)
All URLs are `https://docs.claude-mem.ai/<path>`:
- `introduction.md`, `installation.md`, `configuration.md`, `development.md`, `troubleshooting.md`, `modes.md`, `beta-features.md`, `endless-mode.md`, `context-engineering.md`, `progressive-disclosure.md`, `file-read-gate.md`, `hooks-architecture.md`, `openclaw-integration.md`, `platform-integration.md`, `smart-explore-benchmark.md`, `architecture-evolution.md`
- Architecture: `architecture/overview.md`, `architecture/database.md`, `architecture/hooks.md`, `architecture/search-architecture.md`, `architecture/worker-service.md`, `architecture/pm2-to-bun-migration.md`
- Usage: `usage/getting-started.md`, `usage/folder-context.md`, `usage/search-tools.md`, `usage/knowledge-agents.md`, `usage/claude-desktop.md`, `usage/export-import.md`, `usage/gemini-provider.md`, `usage/openrouter-provider.md`, `usage/private-tags.md`, `usage/manual-recovery.md`
- Editor integrations: `cursor/index.md`, `cursor/gemini-setup.md`, `cursor/openrouter-setup.md`, `gemini-cli/setup.md`

(The OpenAPI JSON `api-reference/openapi.json` from llms.txt is excluded — raw JSON is poor NotebookLM source material.)

### C. Repo root files (7)
Via `https://github.com/thedotmack/claude-mem/blob/main/<file>`:
- `README.md`, `CLAUDE.md`, `CHANGELOG.md`, `LICENSE`, `WARP.md`, `ANTI-PATTERN-TODO.md`, `package.json`

### D. Repo `/docs` directory (batch — to be listed at runtime)
Use `gh api repos/thedotmack/claude-mem/contents/docs` to enumerate. Add each `.md` file under `docs/` via GitHub blob URL. Expected ~10–15 files (skip if already covered by the public docs site to avoid duplicates — dedupe by filename stem before adding).

### E. Key source/plugin files as code context (5–8)
- `src/` entry point(s) (e.g., `src/index.ts` if present) — located via `gh api repos/thedotmack/claude-mem/contents/src` at runtime, add top 3–5 orientation files.
- `plugin/` manifest / entry — `.claude-plugin/` manifest, `package.json` already covered.
- `.mcp.json` (repo root) — defines MCP wiring.

### F. GitHub community (~10)
- Top 5–10 open issues (sorted by reactions or comments) — via `gh issue list -R thedotmack/claude-mem --state open --sort=comments --limit 10 --json number,title,url`, then add each issue URL.
- Top 3 closed issues with high engagement (same query, `--state closed`).
- Discussions tab landing page if enabled: `https://github.com/thedotmack/claude-mem/discussions`.

### G. Ecosystem / companion references (~6)
- Claude Agent SDK docs (official Anthropic page — look up current URL, do not fabricate).
- ChromaDB docs root: `https://docs.trychroma.com/`
- Bun docs root: `https://bun.sh/docs`
- uv (Astral) docs: `https://docs.astral.sh/uv/`
- Discord invite landing (will likely fail; acceptable — include once, let it fail, delete in cleanup).
- X/Twitter `@Claude_Memory` (will likely fail; same treatment).

**Running total:** 2 + 35 + 7 + ~12 + ~7 + ~10 + ~6 ≈ **~79 sources** (buffer absorbs dedup/failures landing us in the 60–80 target).

### Explicit skip list
- Medium.com URLs (memory `feedback_medium_urls_fail.md`).
- Raw API JSON, binary/large non-text files.
- Any URL requiring auth.

## Execution steps

1. **Pre-flight:** run `mcp__notebooklm-rpc__refresh_auth` if any call fails with auth error. If that fails, instruct user to run `notebooklm-mcp-auth` in terminal (stored at `~/.notebooklm-mcp/auth.json` per project memory).
2. **Create notebook:** `notebook_create(title="claude-mem :: docs")` → capture `notebook_id`.
3. **Enumerate dynamic sets (D, E, F):** run the `gh api` / `gh issue list` calls above; build the final URL list; dedupe against sets B & C by filename stem and URL.
4. **Add sources in parallel batches of 10** via `notebook_add_url(notebook_id, url)`. Order: A → B → C → D → E → F → G (stops early-failure contagion: highest-quality first).
5. **Fallback for failures:** for any GitHub `blob/` URL returning status 3, fetch raw content from `https://raw.githubusercontent.com/thedotmack/claude-mem/main/<path>` via WebFetch, then `notebook_add_text(notebook_id, content, title=<filename>)`. (Pattern from `modular-whistling-snail.md`.)
6. **Cleanup:** run `notebook_get(notebook_id)`; delete any remaining status-3 sources via `source_delete(confirm=True)` in parallel batches of 10 (per `feedback_notebooklm_dedup_workflow.md`).
7. **Dedupe:** group sources by URL, keep newest per group, delete rest.

## Verification

- `notebook_get(notebook_id)` — confirm 60–80 healthy sources remain, zero status-3.
- `notebook_describe(notebook_id)` — read the AI summary; confirm it mentions claude-mem core concepts (hooks, Chroma, progressive disclosure, memory compression). If the summary is vague, flag source-quality issues.
- Spot-check 3 sources with `source_describe` — confirm non-empty content.
- Save new project memory on completion: notebook ID, final source count, date.

## Out of scope (explicit)

- No audio overview, video, slide deck, quiz, or mind map generation. Notebook creation only. (Ask user separately if they want artifacts.)
- No browser automation (Playwright path unused).
- No `research_start` deep-research sweep — rejected in favor of curated source list to keep signal high.
- No CSV edits, no changes to existing code files.
