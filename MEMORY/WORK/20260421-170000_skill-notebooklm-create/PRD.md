---
task: Build notebooklm-create skill from session workflow
slug: 20260421-170000_skill-notebooklm-create
effort: advanced
phase: complete
progress: 28/28
mode: interactive
started: 2026-04-21T17:00:00Z
updated: 2026-04-21T17:15:00Z
---

## Context

Capture the full two-turn workflow we just executed — (1) build cmux :: docs notebook with deep-research + forum sources + memory-aware URL gotchas, (2) build full Studio + curate 9 NotebookLM prompts — into a reusable, topic-agnostic skill called `notebooklm-create`.

**Naming:**
- Directory: `~/Repos/github/claude-code-skills/skills/notebooklm-create-skill/` (matches repo convention)
- Skill `name` field: `notebooklm-create` (per user request, corrected spelling)

**Scope boundary vs existing `notebooklm-skill`:**
- `notebooklm-skill` = low-level API surface (notebooklm-py CLI / Python)
- `notebooklm-create` = high-level workflow pattern (research → notebook → sources → studio → prompts) using the notebooklm-rpc MCP tools

### Plan
1. Draft SKILL.md with workflow phases, decision tree, and embedded "what to invoke when"
2. Bundle scripts/ — helpers for the repeatable pieces (sequential URL add with gotcha skips, studio batch with confirm guard, prompt adapter)
3. Bundle references/ — url-gotchas.md (Medium/Quora/llms.txt), studio-quirks.md (quiz classification, sync vs async), prompt-library.md (the 9 XDA+AI Fire templates)
4. Bundle assets/ — templates for research synthesis, community content, PRD-style checklist
5. Bundle samples/ — the cmux :: docs build as a worked example
6. Create evals/evals.json with 3 realistic test prompts (different topics)
7. Symlink into `~/.claude/skills/` so it's discoverable at session start

## Criteria

### SKILL.md
- [x] ISC-1 [E]: SKILL.md exists with valid YAML frontmatter
- [x] ISC-2 [E]: `name` field equals `notebooklm-create`
- [x] ISC-3 [I]: Description is "pushy" (explicit triggers, not undertriggering)
- [x] ISC-4 [I]: Description mentions NotebookLM, notebook creation, deep research, studio, sources
- [x] ISC-5 [I]: SKILL.md body under 500 lines
- [x] ISC-6 [I]: Workflow expressed as distinct phases (intent → research → create → sources → studio → prompts → verify)

### Bundled Scripts
- [x] ISC-7 [E]: scripts/ directory exists
- [x] ISC-8 [E]: `add_urls_sequential.sh` (or .py) helper that adds URLs one-by-one with domain blocklist
- [x] ISC-9 [E]: `build_full_studio.sh` helper that invokes all 10 studio types with confirm guard
- [x] ISC-10 [E]: `adapt_prompts.md` template with the 9 base prompt templates ready to fill

### Bundled References
- [x] ISC-11 [E]: references/url-gotchas.md (Medium/Quora fail, llms.txt .md strip, sequential rule)
- [x] ISC-12 [E]: references/studio-quirks.md (quiz classified as flashcards, sync vs async, confirm guard)
- [x] ISC-13 [E]: references/prompt-library.md (all 9 XDA + AI Fire prompt templates w/ source attribution)
- [x] ISC-14 [E]: references/mcp-tool-map.md (which notebooklm-rpc tools to call per phase)

### Bundled Assets
- [x] ISC-15 [E]: assets/research_synthesis_template.md
- [x] ISC-16 [E]: assets/community_content_template.md
- [x] ISC-17 [E]: assets/workflow_checklist.md

### Samples
- [x] ISC-18 [E]: samples/cmux_docs_walkthrough.md — real worked example from this session
- [x] ISC-19 [I]: Sample cites actual notebook ID and artifact IDs for verifiability

### Evals
- [x] ISC-20 [E]: evals/evals.json exists with valid schema
- [x] ISC-21 [I]: At least 3 realistic test prompts covering different topic domains
- [x] ISC-22 [I]: Prompts reflect real user language (not abstract)

### Integration
- [x] ISC-23 [E]: Skill directory at `~/Repos/github/claude-code-skills/skills/notebooklm-create-skill/`
- [x] ISC-24 [I]: Symlinked into `~/.claude/skills/notebooklm-create-skill/`
- [x] ISC-25 [R]: Skill discoverable (SKILL.md readable from symlinked path)

### Anti-Criteria
- [x] ISC-A1: No cmux-specific hardcoded references outside samples/
- [x] ISC-A2: No silent override of existing notebooklm-skill
- [x] ISC-A3: No unverified assertions (every claim in the skill traces to this session's actual work)
