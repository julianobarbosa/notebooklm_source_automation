#!/usr/bin/env bash
# PreToolUse hook for `notebooklm *` Bash commands.
# Injects the project's pt-BR rule into the model context so every
# NotebookLM operation in this project produces pt-BR output.
#
# Layered defense:
#  1. CLAUDE.md            — instruction layer (Claude reads on session start)
#  2. notebooklm persona   — service layer (NotebookLM enforces per notebook)
#  3. THIS hook            — harness layer (deterministic, fires every call)
#
# Wired in .claude/settings.json under hooks.PreToolUse with:
#   if: "Bash(notebooklm *)"

cat <<'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "PROJECT RULES (notebooklm_source_automation/CLAUDE.md):\n\n=== Rule 1: All NotebookLM operations MUST run in pt-BR ===\n- `notebooklm ask <question>` — the question must be in pt-BR, OR prepend 'Responda em pt-BR. ' to it.\n- `notebooklm configure --persona ...` — the persona must include the pt-BR directive (see CLAUDE.md for the canonical persona string).\n- Synthesized reports written from NotebookLM output use pt-BR (verdict labels, headings, recommendations). Verbatim Gemini quotes stay verbatim — do not back-translate cited text.\n- Code blocks, file paths, command/flag names, source URLs/titles, citation markers, and protocol acronyms (WPA3, PMF, DFS, OFDMA, 802.11k/v/r, OpenWrt, MiWiFi) stay in English.\n- The currently active notebook (6066354e-2821-4fb3-8592-a6d8f238ede2) already has the pt-BR persona configured. For any other notebook touched by this project, set the persona BEFORE the first ask.\n\n=== Rule 2: Research mode MUST be `deep` ===\n- `notebooklm source add-research <query>` — ALWAYS pass `--mode deep`. The CLI's default is `fast`; the project mandates `deep` for higher-quality, source-rich results.\n- If you intentionally need `fast` (cost/time constrained, exploratory probe), state the reason in your update and pass `--mode fast` explicitly — do not silently accept the CLI default.\n- Combine with `--import-all` only when the query is well-scoped; otherwise review results first."
  }
}
JSON
