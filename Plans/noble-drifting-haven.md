# Plan — Relatório pt-BR: Regras de Visibilidade do Perfil LinkedIn

## Context

O usuário rodou `notebooklm ask` no notebook `linkedin :: profile` (`6fe5f866-8c9e-4b98-83e9-78c711b4fc5e`) perguntando sobre as principais regras para melhorar a visibilidade do perfil `https://www.linkedin.com/in/juliano-barbosa`. O NotebookLM retornou uma resposta extensa em pt-BR cobrindo 7 áreas (Headline, Perfil Bilíngue, About, Experience STAR/XYZ, Skills, Recomendações, Visibilidade/Engajamento) com citações inline `[1]` a `[47]`.

A resposta vive apenas no histórico da conversa e na memória do CLI. O usuário quer materializar essa resposta como um relatório markdown pt-BR persistente no repositório, seguindo as convenções já existentes em `MEMORY/` (onde moram `linkedin-profile-final-report.md`, `linkedin-briefing-doc-ptbr.md`, etc.).

**Outcome desejado:** um arquivo markdown consultável e versionado que sintetiza a resposta do notebook em estrutura padrão pt-BR, com citações preservadas e gaps honestos documentados.

## Recommended approach

Gerar um único arquivo markdown sintético — não um dump cru. A resposta original do notebook fica como base verbatim em uma seção `## Resposta verbatim do NotebookLM` (sem back-translate), enquanto a análise pt-BR (resumo executivo, ações priorizadas para o perfil real do Juliano, gaps) fica em seções acima.

### Target file

`/Users/juliano.barbosa/Repos/github/notebooklm_source_automation/MEMORY/linkedin-visibility-rules-report-ptbr.md`

### Structure

```markdown
# Regras de Visibilidade do Perfil LinkedIn — Síntese pt-BR

> Atualizado: 2026-05-09 · Notebook: `linkedin :: profile` (`6fe5f866-8c9e-4b98-83e9-78c711b4fc5e`)
> Conversation ID: `70a7cbdc-cc7c-4fb1-84fc-ea2f04e77f2e`
> Perfil-alvo: https://www.linkedin.com/in/juliano-barbosa

## Resumo executivo
- 3-4 frases: as 7 áreas, ordem de impacto, ponto cego principal

## As 7 regras em ordem de impacto
1. **Engenharia do Headline** — fórmula Cargo + Stack + Impacto; evitar buzzwords [1-8]
2. **Arquitetura bilíngue** — usar recurso nativo "Adicionar perfil em outro idioma", não híbrido [9-16]
3. **About como elevator pitch** — primeira pessoa, densidade de keywords [17-22]
4. **Experience com métricas (STAR/XYZ)** — resultados, não responsabilidades [23-27]
5. **Skills estratégicas** — fixar top-3, extrair termos exatos das vagas [28-33]
6. **Recomendações como prova social** — 3+ recomendações = 14× views [34-40]
7. **Visibilidade & engajamento** — Open to Work privado, atividade semanal, URL custom [40-47]

## Aplicação ao perfil juliano-barbosa
Tabela: cada regra → estado atual presumido → ação concreta sugerida → prioridade
(observação: "presumido" porque não inspecionei o perfil ao vivo nesta sessão)

## Lacunas honestas
| Gap | Razão | Mitigação |
|---|---|---|
| Estado real do perfil não inspecionado | Não rodei scrape ao vivo de linkedin.com (em-scope da regra Apify se for fazer) | Próximo passo: usar Apify ou inspeção manual antes de aplicar mudanças |
| Citações `[1]`-`[47]` não resolvidas para títulos de fonte | NotebookLM retornou números, não os títulos das fontes | Rodar `notebooklm source list` e mapear os 4 documentos do notebook às faixas de citação |
| Sem comparação contra benchmark (perfis de DevOps/FinOps com alta visibilidade) | Fora do escopo da pergunta original | Pergunta de follow-up ao notebook se desejado |

## Resposta verbatim do NotebookLM
> [Bloco com a resposta original na íntegra, citações `[n]` preservadas, sem tradução]

## Próximos passos sugeridos
- [ ] Listar os 4 sources do notebook e mapear faixas de citação
- [ ] Decidir se aplica as mudanças manualmente ou via outro plano (apply-to-profile)
- [ ] (Opcional) Gerar artefatos NotebookLM (mind-map, slide-deck) a partir deste mesmo notebook
```

### Key conventions applied

- **pt-BR em toda prosa de análise**, headings, labels (`Lacunas honestas`, não `Honest Gaps`).
- **Verbatim block preserva** a resposta do Gemini sem back-translate (regra do projeto).
- **Citações `[1]`-`[47]` mantidas como estão**, em inglês onde aplicável (são marcadores, não conteúdo).
- **URLs, file paths, command names em inglês** (`notebooklm ask`, `https://www.linkedin.com/in/juliano-barbosa`).
- **Front matter com data + notebook ID + conversation ID** — espelha o padrão de `linkedin-profile-final-report.md`.

### Critical files

- **Write**: `MEMORY/linkedin-visibility-rules-report-ptbr.md` (novo)
- **Read (referência de estilo)**: `MEMORY/linkedin-profile-final-report.md`, `MEMORY/linkedin-briefing-doc-ptbr.md` (para casar o tom/estrutura existentes)
- **Source de verdade da resposta**: histórico da conversa atual (a resposta verbatim já está acima nesta sessão; será embutida no relatório)

### Reused patterns

- Estrutura de seções (`## Resumo executivo` → corpo temático → `## Lacunas honestas` → `## Próximos passos`) já presente em `MEMORY/linkedin-briefing-doc-ptbr.md`.
- Convenção de filename `linkedin-{topic}-{descriptor}.md` já estabelecida na pasta.
- Tabela de gaps com colunas `Gap | Razão | Mitigação` espelha o padrão da rodada FinOps de 2026-05-05.

## Verification

1. `ls MEMORY/linkedin-visibility-rules-report-ptbr.md` — arquivo existe.
2. Inspeção visual: front matter completo, 7 regras numeradas, tabela de aplicação ao perfil, bloco verbatim com citações `[n]` intactas, lacunas honestas preenchidas.
3. `grep -c '\[' MEMORY/linkedin-visibility-rules-report-ptbr.md` — deve retornar contagem alta (citações preservadas).
4. `grep -i 'unverified\|honest gaps' MEMORY/linkedin-visibility-rules-report-ptbr.md` — deve retornar zero (labels corretos em pt-BR).
5. Diff opcional contra `MEMORY/linkedin-briefing-doc-ptbr.md` para confirmar consistência de estrutura.
6. (Opcional) `git status MEMORY/` — confirma que o arquivo é tracked (não está em `.gitignore`).

## Out of scope

- Aplicar mudanças no perfil real do LinkedIn (sem escrita em `linkedin.com` nesta etapa).
- Scrape ao vivo do perfil para baseline (seria outro plano, usando Apify por regra do projeto).
- Geração de artefatos NotebookLM (slide-deck, mind-map, audio) — fica como follow-up sugerido na seção "Próximos passos" do relatório.
- Commit/push do arquivo — deixar para o usuário decidir após revisar o conteúdo.
