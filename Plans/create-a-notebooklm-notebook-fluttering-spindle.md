# Plan: Create NotebookLM `python :: uv :: docs` from docs.astral.sh/uv

## Context

Build a comprehensive NotebookLM notebook covering Astral's [uv](https://docs.astral.sh/uv/) Python package & project manager. Target: a single notebook that can answer install, project, dependency, tooling, Python-version, pip-interface, configuration, integration, and CLI/settings reference questions end-to-end — entirely in pt-BR per the project's mandatory language rule.

**Title (exact, approved by user):** `python :: uv :: docs`
**Scope (approved):** Complete coverage of the official uv documentation site (every page reachable from `/uv/`), capped by NotebookLM's source limit. No community/blog/ecosystem sources unless we have headroom under the cap.
**Language:** pt-BR persona bound to the notebook before any `ask`/artifact generation.

## Approach: MCP API (`notebooklm-rpc`) — mirror prior pattern

Use `mcp__notebooklm-rpc__*` tools directly. Same pattern as `Plans/create-a-enterily-notebooklm-sharded-pillow.md` (claude-mem :: docs) and `Plans/modular-whistling-snail.md` (MCP-based notebook builds). No Playwright (the legacy `main.py` path is irrelevant here), no CSV.

**Why MCP over CLI shell calls:** parallel `notebook_add_url` batches, atomic source IDs returned per call, no shell-quoting hazards on URLs, no PreToolUse hook noise per call (the hook still fires for any direct `notebooklm` CLI use, but MCP calls bypass it — pt-BR enforcement comes from `chat_configure` setting the persona).

## Critical files to reuse / reference

- `Plans/create-a-enterily-notebooklm-sharded-pillow.md` — canonical template for "build complete docs notebook from llms.txt" pattern (sets A/B/C/D/E sectioning, status-3 cleanup loop, parallel batches of 10).
- `persona_config.json` (project root) — **reuse the `persona` string verbatim** when calling `chat_configure`. Already includes the `[NÃO VERIFICADO]` discipline that this project's reports depend on.
- `CLAUDE.md` (project root) — defines the pt-BR + `--mode deep` non-negotiables and the canonical persona snippet.
- `.claude/hooks/notebooklm-ptbr-rule.sh` — fires on every `Bash(notebooklm *)` call; not in the MCP path, but governs any CLI fallback.

**No edits** to `main.py`, `functions/`, CSVs, hook scripts, settings, or persona_config.json. Plan is creation-only inside NotebookLM.

## Source inventory strategy

uv publishes a canonical doc URL inventory at **`https://docs.astral.sh/uv/llms.txt`** (and `llms-full.txt`). Use it as the single source of truth — exact same trick that worked for claude-mem's `llms.txt`. Do **not** hand-curate the URL list at plan time; fetch llms.txt at execute time so the inventory matches the live docs.

### A. Primary entry point (1)
- `https://docs.astral.sh/uv/` — docs landing (also seeds NotebookLM's auto-summary).

### B. Docs site — full sweep from `llms.txt` (≈45–55 URLs)
Fetch `https://docs.astral.sh/uv/llms.txt`, parse it into the URL list, dedupe against set A. Expected coverage (verify against fetched llms.txt — these are predicted, not hand-listed for execution):

- **Getting started:** installation, first-steps, features, help
- **Guides:** install-python, projects, scripts, tools, package
- **Guides / Integration:** aws-lambda, jupyter, docker, fastapi, gitlab, github, pre-commit, marimo, dependency-bots, alternative-indexes
- **Concepts / Projects:** layout, init, dependencies, run, sync, lock, config, build, workspaces
- **Concepts (top-level):** tools, python-versions, resolution, caching, authentication, configuration-files, build-backend
- **The pip interface:** intro, environments, packages, dependencies, inspection, compile, compatibility
- **Reference:** cli, settings, environment, resolver-internals, policies/versioning, troubleshooting, benchmarks, installer

### C. Reference monoliths (1, conditional)
- `https://docs.astral.sh/uv/reference/cli/` — already in B if present in llms.txt, but if NotebookLM's chunker truncates this single very long page, also add the raw markdown via `notebook_add_text` using the `llms-full.txt` slice for `/reference/cli/` as fallback. Decide at execute time after first `notebook_get`.

### D. GitHub repo anchors (3) — only if under cap after B
- `https://github.com/astral-sh/uv` — repo root README (overview from another angle)
- `https://github.com/astral-sh/uv/blob/main/CHANGELOG.md` — version history (often the only place breaking changes are spelled out)
- `https://github.com/astral-sh/uv/blob/main/CONTRIBUTING.md` — internal architecture hints

### Explicit skip list
- `llms.txt` and `llms-full.txt` themselves (they ARE the manifest, not content — adding them confuses the chunker).
- Any RSS/atom feeds.
- Any `.json` API references (poor NotebookLM source material — same rationale as the openapi.json skip in the claude-mem plan).
- Anything requiring auth.

### Cap math
Standard NotebookLM plan = 50 sources. Plus = 100. Pro = 300. **Predicted total ≈ 49–55** (set B alone). If we exceed 50 and the user is on Standard:
1. Drop set D (saves 3).
2. Collapse `/concepts/projects/{layout,init,dependencies,run,sync,lock,config,build,workspaces}` (9 URLs) into a single `notebook_add_text` blob fetched from `llms-full.txt` (saves 8 net).
3. Confirm with user before doing #2.

Do not silently truncate. Surface the cap before adding.

## Execution steps (DO NOT RUN until plan approved)

1. **Pre-flight auth.** Call `mcp__notebooklm-rpc__notebook_list` once. If it returns auth error, run `mcp__notebooklm-rpc__refresh_auth`; if that still fails, instruct user to run `notebooklm-mcp-auth` in terminal.
2. **Fetch the canonical URL inventory.** `WebFetch` on `https://docs.astral.sh/uv/llms.txt`. Parse into a deduped URL list (strip anchors, drop trailing slashes consistently). Print count to user — abort and reconfirm if count > 50 unless user has confirmed Plus+ plan.
3. **Create notebook.** `mcp__notebooklm-rpc__notebook_create(title="python :: uv :: docs")` → capture `notebook_id`. Echo it to the user.
4. **Bind pt-BR persona FIRST (before any ask).** `mcp__notebooklm-rpc__chat_configure(notebook_id, persona=<persona string from persona_config.json>, mode="detailed", response_length="longer")`. This is the project's non-negotiable pt-BR rule, layered at the service level.
5. **Add sources in parallel batches of 10.** Order: A → B (in llms.txt order — getting-started first so NotebookLM's auto-summary anchors on the right framing) → optional D. Use `mcp__notebooklm-rpc__notebook_add_url(notebook_id, url)` per URL. Capture each returned `source_id` and status.
6. **Status-3 cleanup loop.** After all batches, `notebook_get(notebook_id)`. For any source with status 3 (failed): delete via `source_delete(source_id, confirm=True)`. Re-attempt those failed URLs once via `notebook_add_text` using the corresponding section from `llms-full.txt`.
7. **Dedupe.** Group remaining sources by canonical URL; keep newest per group; delete the rest. (Cheap insurance — `llms.txt` shouldn't have dupes, but NotebookLM occasionally double-indexes redirects.)
8. **Final verification (see below).**
9. **Save outcome to project memory.** Note the `notebook_id`, final source count, and date — same convention as the claude-mem plan step 7.

## Verification (end-to-end)

- `notebook_get(notebook_id)` → confirm: title is **exactly** `python :: uv :: docs`; source count is in the predicted band (≥45, ≤cap); zero status-3 sources remain.
- `notebook_describe(notebook_id)` → read NotebookLM's auto-summary. **Must mention** uv core concepts: lockfile, resolver, Python version management, pip-compatible interface, project workspaces, tool install. If the summary is vague or English-only, flag source-quality OR persona-binding issue.
- Spot-check 3 sources via `source_describe`: pick `/getting-started/installation/`, `/reference/cli/`, `/concepts/resolution/`. Confirm non-empty extracted content.
- **pt-BR smoke test** — `notebook_query(notebook_id, "Como instalo o uv no macOS?")`. Response must be in pt-BR (per persona binding) and cite at least one source. If the response is in English, persona binding failed → re-run step 4 and re-test.

## Out of scope (explicit)

- No audio overview, video, slide deck, infographic, mind map, quiz, or flashcards. Notebook + sources only. (Ask user separately if they want any artifact — those are unreliable per the skill's known-limitations table and will rate-limit a fresh notebook.)
- No browser automation (Playwright path unused — `main.py`, `functions/links.py`, CSVs untouched).
- No `research_start` deep-research sweep. uv's llms.txt is curated and exhaustive; adding research noise hurts signal. The project's `--mode deep` rule applies only IF research is invoked — it isn't here.
- No edits to `persona_config.json`, hooks, settings, or any project file outside `Plans/`.

---

# Plan 2: Completely remove `notebooklm-rpc` MCP from configuration

## Context

The MCP server `notebooklm-rpc` is currently disconnected (its tools became deferred-but-unavailable mid-session) and is shown as `disabled` in `/mcp`. Plan 1 (above) used this MCP to build the `python :: uv :: docs` notebook, so the work is done — there is no ongoing dependency on the server. The user wants a **complete removal from configuration** so the entry stops appearing in `/mcp`, no permission noise lingers in `settings.local.json`, and (optionally) the cached Google auth + the locally-installed launcher binary go away too.

## Where `notebooklm-rpc` lives (exhaustive inventory)

| Layer | File / Path | What's there | Action |
|------|-------------|--------------|--------|
| Claude Code user state | `/Users/juliano.barbosa/.claude.json` (lines **1864–1869**) | `"notebooklm-rpc": { type, command, args, env }` inside the `mcpServers` block of project `/Users/juliano.barbosa/Repos/github/notebooklm_source_automation` | **Edit — remove the entry**, leaving `"mcpServers": {}` |
| Claude Code user state | `/Users/juliano.barbosa/.claude.json` (lines **1939–1941**) | `"disabledMcpServers": ["notebooklm-rpc"]` in the same project block | **Edit — empty the array**, leaving `"disabledMcpServers": []` |
| Project local settings | `/Users/juliano.barbosa/Repos/github/notebooklm_source_automation/.claude/settings.local.json` (lines **4–10, 14–24, 27**) | 19 individual `mcp__notebooklm-rpc__*` permission entries inside `permissions.allow` | **Edit — remove the 19 entries**. Preserve lines 11–13 (repomix) and 25–26 (`Bash(...)`). Result: `permissions.allow` shrinks from 25 entries to 6. |
| Cached Google auth | `/Users/juliano.barbosa/.notebooklm-mcp/` (4.1k `auth.json` + `chrome-profile/`) | OAuth cookies + Chrome profile used for headless NotebookLM auth | **Optional — ask user before deleting**. Removing this forces a re-auth via `notebooklm-mcp-auth` if they ever re-add the MCP. |
| Launcher binary | `/Users/juliano.barbosa/.local/bin/notebooklm-mcp` | Entry point of the `notebooklm-mcp` Python package | **Optional — ask user before uninstalling**. The package is `notebooklm-mcp` (likely installed via `uv tool install` or pipx). Uninstall via `uv tool uninstall notebooklm-mcp` or `pipx uninstall notebooklm-mcp` — pick whichever owns it. |

The MCP does NOT appear in:
- `~/.claude/settings.json`, `~/.claude/settings.local.json` — unrelated.
- Project `.mcp.json` — file does not exist for this project.
- `CLAUDE.md`, `.claude/hooks/` — only references in scope are to the rules around `notebooklm` (the unrelated CLI), not the MCP.

## Critical files / utilities to reuse

- `Edit` tool with anchored line context — both target files are JSON, so edits must preserve trailing-comma / brace structure. The `mcpServers` block already has just one key so removal collapses to `"mcpServers": {}` (no comma juggling). The `disabledMcpServers` array has one element so it collapses to `[]`. The `permissions.allow` array has 25 elements with mixed targets — surgical removal of the 19 `mcp__notebooklm-rpc__*` strings is needed.
- No PAI tooling re-use — this is a one-off config edit.

## Execution steps (do not run until plan approved)

1. **Edit `~/.claude.json`** — under project key `/Users/juliano.barbosa/Repos/github/notebooklm_source_automation`:
   - Replace the entire `"mcpServers": { "notebooklm-rpc": {...} }` block with `"mcpServers": {}`.
   - Replace `"disabledMcpServers": ["notebooklm-rpc"]` with `"disabledMcpServers": []`.
2. **Edit `<project>/.claude/settings.local.json`** — strip the 19 `mcp__notebooklm-rpc__*` strings from `permissions.allow`. Final array (in original order):
   ```json
   [
     "mcp__plugin_repomix-mcp_repomix__pack_remote_repository",
     "mcp__plugin_repomix-mcp_repomix__read_repomix_output",
     "mcp__plugin_repomix-mcp_repomix__grep_repomix_output",
     "Bash(mkdir -p ~/.claude/PAI/MEMORY/KNOWLEDGE/Ideas)",
     "Bash(cat)"
   ]
   ```
3. **Confirm with user** before doing either of the optional filesystem actions:
   - Delete `~/.notebooklm-mcp/` (auth + chrome profile).
   - Uninstall the `notebooklm-mcp` Python package (detect `uv tool list | grep notebooklm` first; fall back to `pipx list` and `pip show notebooklm-mcp`).

## Verification

- Re-open `/mcp` in Claude Code → `notebooklm-rpc` no longer appears in the list.
- `grep -n "notebooklm-rpc\|notebooklm_rpc" ~/.claude.json /Users/juliano.barbosa/Repos/github/notebooklm_source_automation/.claude/settings.local.json` → returns nothing.
- `python -c "import json; json.load(open('/Users/juliano.barbosa/.claude.json'))"` and the same on `settings.local.json` → both parse without error (JSON validity preserved).
- `ls /Users/juliano.barbosa/Repos/github/notebooklm_source_automation/.claude/settings.local.json` still exists and `permissions.allow` retains the 6 non-notebooklm entries.
- (If filesystem cleanup approved) `ls ~/.notebooklm-mcp` returns "No such file"; `which notebooklm-mcp` returns nothing.

## Out of scope (explicit)

- The `python :: uv :: docs` notebook itself stays. The MCP removal does not delete any NotebookLM data — the notebook lives in Google's cloud, accessible at the URL recorded in Plan 1's summary.
- The project's `notebooklm` (CLI) rules in `CLAUDE.md` and the `notebooklm-ptbr-rule.sh` hook are untouched. They govern the unrelated `notebooklm` CLI tool, not the `notebooklm-rpc` MCP.
- No git commits, no settings changes outside the two files listed above.
