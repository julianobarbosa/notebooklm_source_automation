# Plan: Create NotebookLM "memplace :: milla" from MemPalace GitHub Repo

## Context

Create a complete NotebookLM notebook named `memplace :: milla` populated with all documentation from the [MemPalace](https://github.com/MemPalace/mempalace) GitHub repository. MemPalace is an AI memory system (persistent, high-recall memory for conversational AI) with ChromaDB + SQLite backend, MCP integration, and comprehensive docs.

## Approach: MCP API (`notebooklm-rpc`)

Use the NotebookLM MCP tools directly — no browser automation needed. The repo has ~30+ documentation files ideal as notebook sources.

## Steps

### Step 1: Create the notebook
- `notebook_create(title="memplace :: milla")`
- Capture the `notebook_id`

### Step 2: Add the main repo URL
- `notebook_add_url(notebook_id, "https://github.com/MemPalace/mempalace")`

### Step 3: Add documentation URLs (batch, parallel where possible)

**Root docs:**
- `https://github.com/MemPalace/mempalace/blob/main/README.md`
- `https://github.com/MemPalace/mempalace/blob/main/AGENTS.md`
- `https://github.com/MemPalace/mempalace/blob/main/ROADMAP.md`
- `https://github.com/MemPalace/mempalace/blob/main/CONTRIBUTING.md`

**Concepts (website/concepts/):**
- `the-palace.md` — Core architecture metaphor
- `memory-stack.md` — 4-layer memory system
- `knowledge-graph.md` — Temporal entity graph
- `aaak-dialect.md` — AAAK compression
- `agents.md` — Agent diary system

**Guides (website/guide/):**
- `getting-started.md`
- `mining.md`
- `searching.md`
- `mcp-integration.md`
- `configuration.md`
- `hooks.md`
- `claude-code.md`
- `gemini-cli.md`
- `local-models.md`
- `openclaw.md`

**Reference (website/reference/):**
- `cli.md`
- `mcp-tools.md`
- `python-api.md`
- `api-reference.md`
- `benchmarks.md`
- `modules.md`
- `contributing.md`

**Benchmarks:**
- `benchmarks/BENCHMARKS.md`
- `benchmarks/HYBRID_MODE.md`

**Examples:**
- `examples/HOOKS_TUTORIAL.md`

All URLs use the pattern: `https://github.com/MemPalace/mempalace/blob/main/{path}`

**Total sources: ~30 URLs + 1 repo root = ~31 sources**

### Step 4: Verify
- `notebook_get(notebook_id)` to confirm all sources loaded
- Check for any failed sources and retry or add as text if needed

### Step 5: Rename if needed
- Confirm title is `memplace :: milla`

## Fallback: GitHub URL failures

If raw GitHub blob URLs fail in NotebookLM (some do), fallback strategy:
1. Fetch the raw file content via `WebFetch` from `https://raw.githubusercontent.com/MemPalace/mempalace/main/{path}`
2. Add as text source via `notebook_add_text(notebook_id, content, title)`

## Verification
- Run `notebook_get(notebook_id)` and confirm ~31 sources present
- Run `notebook_describe(notebook_id)` for AI summary to verify content quality
- Report final source count and any failures

## NotebookLM Source Limit
- Max 300 sources per notebook — we're well within limits at ~31
