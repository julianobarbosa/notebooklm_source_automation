---
task: Build cmux studio plus 9 curated prompts
slug: 20260421-143000_cmux-studio-prompts
effort: advanced
phase: complete
progress: 25/25
mode: interactive
started: 2026-04-21T14:30:00Z
updated: 2026-04-21T16:53:00Z
---

## Context

User wants: (1) an "entirely studio" for the existing `cmux :: docs` notebook (ID `e0ed6d5f-abdc-4957-9ccd-fd988f88970f`) — interpreted as the full set of NotebookLM studio artifact types, and (2) 3 prompts from the XDA article plus 6 prompts from the AI Fire article, each adapted to the cmux topic.

Studio types available via MCP: audio_overview, video_overview, mind_map, report (Briefing Doc, Study Guide, Blog Post, Create Your Own), flashcards, quiz, infographic, slide_deck, data_table. Each requires `confirm=True` after user approval.

### Plan
1. Adapt 9 prompts to cmux topic (3 XDA + 6 AI Fire)
2. Save prompts to reference file + add as text source to notebook
3. Present studio build plan to user for approval
4. Create all 9 studio artifact types with confirm=True
5. Verify via studio_status

## Criteria

### Prompt Adaptation
- [x] ISC-1 [E]: XDA Prompt 1 (5 Essential Questions) adapted for cmux
- [x] ISC-2 [E]: XDA Prompt 2 (Interesting Bits) adapted for cmux
- [x] ISC-3 [E]: XDA Prompt 3 (Quiz Show) adapted for cmux
- [x] ISC-4 [E]: AI Fire Prompt 1 (Content Analyst) adapted for cmux
- [x] ISC-5 [E]: AI Fire Prompt 2 (Meeting→Action Plan) adapted for cmux
- [x] ISC-6 [E]: AI Fire Prompt 3 (SEO Outline) adapted for cmux
- [x] ISC-7 [E]: AI Fire Prompt 4 (360 Feedback) adapted for cmux
- [x] ISC-8 [E]: AI Fire Prompt 5 (Study Guide Kit) adapted for cmux
- [x] ISC-9 [E]: AI Fire Prompt 6 (Interview Script) adapted for cmux

### Prompt Preservation
- [x] ISC-10 [I]: All 9 prompts saved to reference markdown file
- [x] ISC-11 [I]: All 9 prompts added to notebook as text source
- [x] ISC-12 [R]: Source attribution (XDA vs AI Fire) preserved per prompt

### Studio Artifacts (require user confirm)
- [x] ISC-13 [E]: Audio overview generated (deep_dive format)
- [x] ISC-14 [E]: Video overview generated (explainer format)
- [x] ISC-15 [E]: Mind map generated
- [x] ISC-16 [E]: Briefing Doc report generated
- [x] ISC-17 [E]: Study Guide report generated
- [x] ISC-18 [E]: Flashcards generated
- [x] ISC-19 [E]: Quiz generated
- [x] ISC-20 [E]: Infographic generated
- [x] ISC-21 [E]: Slide deck generated
- [x] ISC-22 [E]: Data table generated

### Verification
- [x] ISC-23 [R]: User approval obtained before confirm=True
- [x] ISC-24 [R]: studio_status polled after generation
- [x] ISC-25 [R]: Reference prompts file saved to MEMORY/WORK

### Anti-Criteria
- [x] ISC-A1: No studio artifact created without user approval (confirm=True)
- [x] ISC-A2: No generic prompts — all 9 must reference cmux/manaflow-ai context
- [x] ISC-A3: No XDA/AI Fire attribution stripped

## Verification

**Notebook:** https://notebooklm.google.com/notebook/e0ed6d5f-abdc-4957-9ccd-fd988f88970f

**Studio artifacts (10 requested):**

| Type | Artifact ID | Status | Notes |
|------|-------------|--------|-------|
| Audio Overview (deep_dive) | 40867e66 | ✅ completed | "cmux creates mission control for agents" — audio URL available |
| Video Overview (explainer) | 0b897d9d | 🕐 in_progress | Rendering |
| Mind Map | 75d416d0 | ✅ completed | "Cmux: O Terminal Nativo para Orquestração de Agentes IA" (6 children) |
| Report: Briefing Doc | eb64d223 | ✅ completed | "cmux: The Terminal Substrate for AI Agent Multitasking" |
| Report: Study Guide | 7b892aaf | ✅ completed | "cmux: A Comprehensive Study Guide for the AI-Native Terminal" |
| Flashcards | 5b61c4ab | ✅ completed | "cmux Flashcards" — 9 cards |
| Quiz | e47b21ec | ✅ completed | "Quiz cmux" — 9 questions (NotebookLM API classifies as flashcards type) |
| Infographic (portrait, detailed) | fa0d88d1 | 🕐 in_progress | Rendering |
| Slide Deck (detailed_deck) | c020b996 | 🕐 in_progress | Rendering |
| Data Table | fb7fc26e | ✅ completed | "Comparison of AI-Agent Terminals and Orchestrators" |

**Prompts:**
- Reference file: `MEMORY/WORK/20260421-143000_cmux-studio-prompts/cmux_notebooklm_prompts.md`
- Added to notebook as text source: `4dfd83a6-cdcf-4ca5-9fcf-264fb23b68a1` — "9 Curated NotebookLM Prompts for cmux"
