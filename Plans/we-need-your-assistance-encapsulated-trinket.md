# Plan — Create `persona_config.json` for NotebookLM configure

## Context

This project drives `notebooklm` operations (configure / ask / source add-research) under two non-negotiable rules from `CLAUDE.md`: every operation runs in **pt-BR**, and every research call uses **`--mode deep`**. Persona setup today is implicit — whoever activates a notebook either remembers to run `notebooklm configure --persona '…'` by hand or relies on the persona that happens to be set. There is no checked-in source of truth for the four knobs `notebooklm configure` exposes.

The fix is a single file, `persona_config.json`, that captures every parameter accepted by `notebooklm configure` so the project's persona can be reviewed, version-controlled, and re-applied deterministically. Out of scope for this plan: writing the apply-script and wiring it into the harness — those can follow once the config schema is locked.

Parameters collected via interview (all four `notebooklm configure` flags):

| CLI flag | JSON key | Chosen value |
|---|---|---|
| `--notebook` / `-n` | `notebook` | `null` (use current at apply time) |
| `--mode` | `mode` | `detailed` |
| `--persona` | `persona` | Generic technical analyst (pt-BR) — full text below |
| `--response-length` | `response_length` | `longer` |

## Recommended approach

**Create one new file: `persona_config.json` at the project root.** No existing files are modified.

Schema is a flat JSON object keyed by `notebooklm configure` flag names (CLI flags converted to JSON-idiomatic snake_case for `response-length` only — the rest map 1:1). `notebook: null` is the explicit "use whichever notebook is current at apply time" signal — matches the user's choice to leave `-n` unset.

### Proposed file contents

```json
{
  "notebook": null,
  "mode": "detailed",
  "response_length": "longer",
  "persona": "Atue como analista técnico sênior. Responda SEMPRE em português brasileiro (pt-BR). Use terminologia técnica em português; deixe siglas/protocolos/comandos em inglês quando o termo técnico for o original. Citações inline [1], [2] permanecem como estão. Não traduza nomes próprios, nomes de produto, nem trechos de código/CLI/JSON/YAML. Quando uma afirmação não tiver suporte explícito nas fontes do notebook, marque com [NÃO VERIFICADO] e explique o que faltaria para verificar."
}
```

### Why this shape

- **Flat, one key per CLI flag** — trivial to map back to `notebooklm configure …` with `jq`. No nesting, no schema versioning yet (premature).
- **`notebook: null`** instead of omitting the key — explicit beats implicit; reviewers see the field exists and was deliberately left dynamic.
- **`persona` last** — it's the long string; putting it after the short scalars keeps the file scannable when diffed.
- **Persona contains the pt-BR directive** ("Responda SEMPRE em português brasileiro (pt-BR)…") — satisfies project Rule 1 at the persona layer, so any agent/tool querying a notebook configured from this file inherits pt-BR without per-call gymnastics.

## Critical files

| Path | Action |
|---|---|
| `/Users/juliano.barbosa/Repos/github/notebooklm_source_automation/persona_config.json` | **CREATE** with the JSON above |

No existing files are touched. `CLAUDE.md`, `.claude/settings.json`, hooks, and `main.py` are unaffected by this plan.

## Verification

End-to-end check after the file is written:

1. **JSON validity** — `jq . persona_config.json` exits 0 and pretty-prints the object.
2. **Schema matches CLI** — `notebooklm configure --help` lists exactly four configurable knobs (`--notebook`, `--mode`, `--persona`, `--response-length`); confirm `persona_config.json` has a key for each, with `--response-length` mapped to `response_length`.
3. **Enum values** — `mode` ∈ `{default, learning-guide, concise, detailed}`; `response_length` ∈ `{default, longer, shorter}`.
4. **pt-BR rule** — `jq -r .persona persona_config.json | grep -q 'pt-BR'` returns 0 (project Rule 1 holds).
5. **Persona length** — `jq -r .persona persona_config.json | wc -c` < 10000 (CLI cap).
6. **Round-trip dry-run (manual, optional)** — once the apply-script lands, `notebooklm configure -n <id> --mode "$(jq -r .mode persona_config.json)" --response-length "$(jq -r .response_length persona_config.json)" --persona "$(jq -r .persona persona_config.json)"` should succeed against a throwaway notebook and `notebooklm configure --help`-style introspection should reflect the new persona.

Steps 1–5 are the gate for "plan executed correctly." Step 6 belongs to the follow-up apply-script work, not this plan.
