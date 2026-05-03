# Project: notebooklm_source_automation

## NotebookLM language rule (non-negotiable)

**All NotebookLM operations executed inside this project MUST run in `pt-BR`.**

This applies to:

- Every question phrased to a notebook via `notebooklm ask` (or any equivalent skill/MCP/script).
- Every `notebooklm configure --persona` set on a notebook touched by this project.
- Every report, synthesis, or note saved back into a NotebookLM notebook from this project.
- Every artifact generated *from* a NotebookLM response (audio overview, mind map, quiz, slides, infographic, video, study guide, etc.).

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

## Enforcement layer

Both rules above are enforced at three layers:

| Layer | Mechanism | Scope |
| --- | --- | --- |
| Instruction | This `CLAUDE.md` (loaded by Claude on session start in this project) | Every Claude session opened in this directory |
| Service | `notebooklm configure --persona` set on the active notebook | Per-notebook (durable) — propagates to any agent/tool querying that notebook |
| Harness | `PreToolUse` hook on `Bash(notebooklm *)` in `.claude/settings.json` | Every shell call to `notebooklm` from this project, regardless of model |

The harness layer is the deterministic enforcer — it fires automatically and injects this rule set into the model's context on every `notebooklm` Bash call. The hook script lives at `.claude/hooks/notebooklm-ptbr-rule.sh`.
