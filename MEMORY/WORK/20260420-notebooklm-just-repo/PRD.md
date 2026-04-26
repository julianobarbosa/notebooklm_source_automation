---
task: Create NotebookLM from casey/just GitHub repo
slug: 20260420-notebooklm-just-repo
effort: standard
phase: complete
progress: 10/10
mode: interactive
started: 2026-04-20T12:32:54Z
updated: 2026-04-20T12:35:00Z
---

## Context

User requested "create a entirely notebooklm for https://github.com/casey/just". The target is `casey/just` — a Rust-based command runner (~33k stars, homepage https://just.systems). "Entirely" is interpreted as comprehensive source coverage — multiple curated sources spanning the manual, README, changelog, contributing guide, formal grammar, and a canonical justfile example — rather than just one URL or exhaustive every-file ingestion.

### Source Strategy

Seven sources chosen to cover the repo end-to-end:
1. Repo root URL (README + metadata)
2. Full manual printed as single page (https://just.systems/man/en/print.html — 200KB, all chapters)
3. README raw markdown (canonical entry)
4. CHANGELOG (release history)
5. CONTRIBUTING (dev workflow)
6. GRAMMAR.md (formal spec)
7. justfile (real-world example — the project's own)

## Criteria

- [x] ISC-1: [E] New NotebookLM notebook created with descriptive title
- [x] ISC-2: [E] Notebook title references casey/just clearly
- [x] ISC-3: [I] Repo root URL added as source (github.com/casey/just)
- [x] ISC-4: [I] Full manual added as source (just.systems print.html)
- [x] ISC-5: [I] README.md raw URL added as source
- [x] ISC-6: [I] CHANGELOG.md raw URL added as source
- [x] ISC-7: [I] CONTRIBUTING.md raw URL added as source
- [x] ISC-8: [I] GRAMMAR.md raw URL added as source
- [x] ISC-9: [I] justfile raw URL added as source
- [x] ISC-10: [I] Final verification shows notebook has at least 5 successful sources
- [x] ISC-A1: [R] Do NOT generate audio/video/other artifacts (not requested)
- [x] ISC-A2: [R] Do NOT flood the notebook with every repo file (scope discipline)

## Decisions

- Using `just.systems/man/en/print.html` for the manual instead of ~40 separate chapter pages — one comprehensive source beats fragmentation.
- Using `raw.githubusercontent.com` for markdown files so NotebookLM gets clean text, not HTML-rendered GitHub pages.
- Not adding `README.中文.md` — user writing in English; Chinese README would add noise.
- Not adding Cargo.toml/build.rs/source code — user asked about the tool, not Rust internals.

## Verification

Notebook ID: `c0bbb7d0-24ca-4848-ade5-c16aaffe4ba5`
URL: https://notebooklm.google.com/notebook/c0bbb7d0-24ca-4848-ade5-c16aaffe4ba5

Source IDs:
- `76a6ff68-a077-4158-a598-af30671879b0` — GitHub - casey/just: 🤖 Just a command runner
- `d85d83bd-15e5-4ea6-a910-44166fe3ea0f` — Just Programmer's Manual
- `83db43e8-2326-40a6-bd27-c272d8466a8c` — README.md
- `b88b2ef0-7ccb-442e-9fb7-a2007ff3381a` — CHANGELOG.md
- `7d1b8fa6-1e14-492a-b7b9-756a381bbc18` — CONTRIBUTING.md
- `f4abeed9-db70-4e0f-aaae-e4635f82ae7b` — GRAMMAR.md
- `af0dc328-4715-4666-9787-a6eb0f2f4537` — justfile

`notebook_describe` returned a coherent summary referencing content from multiple sources (Rust implementation, justfiles/recipes, cross-platform support, .env, Python/Node recipes, installation, editor config, contributions) — confirming ingestion across sources.
