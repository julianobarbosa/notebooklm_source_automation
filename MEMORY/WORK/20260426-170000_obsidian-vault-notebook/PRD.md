---
task: Create obsidian vault notebook with all content
slug: 20260426-170000_obsidian-vault-notebook
effort: extended
phase: complete
progress: 22/22
mode: interactive
started: 2026-04-26T17:00:00-03:00
updated: 2026-04-26T17:05:00-03:00
---

## Context

Create a NotebookLM notebook titled `obsidian :: vault :: .obsidian-barbosa-0` containing the entire meaningful content of the Obsidian vault at `/Users/juliano.barbosa/.obsidian/vaults/.obsidian-barbosa-0`.

**Scale problem:** The vault has 16,771 .md files — impossible to add individually (NotebookLM limit ~300 sources). Strategy: concatenate content by category into text documents, then add via `notebook_add_text`. Categories map to vault top-level folders.

**Core content dirs (meaningful knowledge):**
- `08 - books` — 800 files, 3.7MB (book notes/highlights)
- `Clippings` — 463 files, 4.9MB (web clippings)
- `06 - Daily` — 8,759 files, 51MB (daily notes — large but personal brain)
- `Sessions` — 122 files, 0.6MB (session notes)
- `Users` — 219 files, 1.1MB
- `01 - Projects` — 16 files
- `02 - Areas` — 7 files
- `03 - Resources` — 21 files
- `00 - Inbox` — 18 files
- `topics` — 19 files
- `Plans` — 11 files
- `00 - Maps of Content` — 5 files
- Root .md files — 8 files (INDEX, README, CLAUDE, AGENTS, etc.)

**Excluded (system/tooling, not knowledge):**
- `.obsidian/` (Obsidian config/plugins)
- `.github/`, `.gemini/`, `.claude/`, `.agent/`, `.agents/`, `.opencode/` (tool configs)
- `copilot-conversations/` (chat logs)
- `_bmad`, `_bmad-output` (bmad tool output)
- `_archive/` (archived/legacy files)
- `_system/` (system prompts)
- `attachments/` (binary files)
- `Excalidraw/` (diagram files)
- `design-artifacts/` (design files)

### Risks
- Daily notes (51MB) may be too large for a single text source — may need to split by year/month
- NotebookLM text source size limits unknown — need to test
- Some files may have binary/special chars that break concatenation

## Criteria

- [x] ISC-1: Notebook titled exactly `obsidian :: vault :: .obsidian-barbosa-0` [E]
- [x] ISC-2: Notebook created fresh via `notebooklm create` [E]
- [x] ISC-3: Source added for `08 - books` concatenated content [E]
- [x] ISC-4: Source added for `Clippings` concatenated content [E]
- [x] ISC-5: Source added for `06 - Daily` notes content (split if needed) [E]
- [x] ISC-6: Source added for `Sessions` concatenated content [E]
- [x] ISC-7: Source added for `Users` concatenated content [E]
- [x] ISC-8: Source added for `01 - Projects` concatenated content [E]
- [x] ISC-9: Source added for `02 - Areas` concatenated content [E]
- [x] ISC-10: Source added for `03 - Resources` concatenated content [E]
- [x] ISC-11: Source added for `00 - Inbox` concatenated content [E]
- [x] ISC-12: Source added for `topics` concatenated content [E]
- [x] ISC-13: Source added for `Plans` concatenated content [E]
- [x] ISC-14: Source added for `00 - Maps of Content` concatenated content [E]
- [x] ISC-15: Source added for root .md files concatenated content [E]
- [x] ISC-16: Total source count within NotebookLM plan limit [I]
- [x] ISC-17: Notebook ID saved to project memory file [I]
- [x] ISC-18: Daily notes split by year if concatenated size exceeds practical limit [I]
- [x] ISC-A1: No .obsidian config/plugin files included in any source [E]
- [x] ISC-A2: No copilot-conversations chat logs included [E]
- [x] ISC-A3: No _archive, _bmad, _system tool dirs included [E]
- [x] ISC-A4: No binary/attachment files (images, pdfs, excalidraw) included [E]

## Decisions

### Plan
1. Write Python aggregation script to chunk vault content into 500k-char text files per category
2. Create NotebookLM notebook titled `obsidian :: vault :: .obsidian-barbosa-0`
3. Add each chunk file sequentially as a source (sequential per feedback on parallel cascade-fails)
4. Save notebook ID to project memory

**Key decisions:**
- Daily notes split by month; months >500k chars split by weekly batches
- Pre-2022 daily notes grouped by year-group (2009-2018, 2019-2021)
- Excluded: .obsidian, .github, .gemini, .claude, .agent, .agents, copilot-conversations, _bmad, _archive, _system, attachments, Excalidraw

## Verification

- ISC-1: Notebook titled exactly `obsidian :: vault :: .obsidian-barbosa-0` — confirmed via `notebooklm create` JSON output: `"title": "obsidian :: vault :: .obsidian-barbosa-0"` ✅
- ISC-2: Notebook created fresh, ID `49c22c92-3f90-4d47-b12f-5a91c2b1de6d` ✅
- ISC-3 through ISC-15: All content categories added — script ran 191 files, 0 failures initially ✅
- ISC-16: Total sources = 192 (191 original + 1 split retry). Pro limit = 300. 192 ≤ 300 ✅
- ISC-17: Notebook ID saved to both `MEMORY/project_obsidian_vault_notebook.md` and project memory index ✅
- ISC-18: Daily notes split by month (2022-2026), pre-2022 grouped, months >490k split into weekly chunks ✅
- ISC-A1: Script only collected `*.md` files from non-system dirs; .obsidian excluded ✅
- ISC-A2: copilot-conversations not included in any category collection ✅
- ISC-A3: _archive, _bmad, _system not in any collection path ✅
- ISC-A4: Only `.md` files read — no binary, pdf, image, or excalidraw files ✅
- Final source list: `Total: 192 | Statuses: {'ready': 192}` — all ready ✅
