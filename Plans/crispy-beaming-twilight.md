# Plan: Individual Podcasts per pi-llm-wiki Function

## Context
The notebook `pi-llm-wiki :: Gestão de Conhecimento Estruturado para IA` (ID: `91d8e8cf-f45a-42eb-9eba-5ec995ac8223`) contains a single source about the pi-llm-wiki package. Instead of one long podcast covering everything, we'll create **individual focused podcasts** — one per tool, command, or architectural topic — each with detailed examples and use cases.

## Source
- **Source ID:** `c77614e2-4d3d-42fe-9f34-c268bf2c2d99`
- **Content:** GitHub README for Kausik-A/pi-llm-wiki (TypeScript, Pi-native LLM wiki package)

## Podcast Series (13 episodes)

Each podcast: `deep_dive` format, `default` length, `pt` language, with a specific `focus_prompt`.

### Episode 1: wiki_bootstrap
**Focus:** Como inicializar um vault do zero. Estrutura de diretórios criada (raw/, wiki/, meta/, .wiki/, WIKI_SCHEMA.md). Config, templates, schema. Exemplo prático: `mkdir my-wiki && cd my-wiki && pi` → "Initialize an llm wiki here for AI research." Explicar cada arquivo e pasta gerado.

### Episode 2: wiki_capture_source
**Focus:** Captura imutável de fontes. Três tipos de input: URLs, arquivos locais (PDFs), texto colado. Formato do source packet (manifest.json, original/, extracted.md, attachments/). Nomenclatura SRC-YYYY-MM-DD-NNN. Fallback markitdown para PDFs. Exemplos: capturar artigo web, capturar PDF local, capturar notas coladas. Imutabilidade — por que raw/ nunca é editado depois.

### Episode 3: wiki_search
**Focus:** Busca no registry gerado da wiki. Como o registry.json é estruturado. Quando usar wiki_search vs ler arquivos diretamente. Exemplos de queries: buscar por conceito, por entidade, por fonte. Papel no fluxo de integração — "search before creating new canonical pages."

### Episode 4: wiki_ensure_page
**Focus:** Resolver ou criar páginas canônicas com segurança. 4 tipos: concept, entity, synthesis, analysis. Quando criar cada tipo. Exemplos: criar página de conceito "retrieval-augmented-generation", entidade "OpenAI", síntese "long-context-vs-rag", análise como resposta durável a uma query. Deduplicação — como ensure_page evita duplicatas.

### Episode 5: wiki_lint
**Focus:** Health checks mecânicos sobre a wiki. 7 modos de lint: all, links, orphans, frontmatter, duplicates, coverage, staleness. O que cada modo detecta. Exemplos de problemas encontrados: links quebrados, páginas órfãs, aliases duplicados, gaps de cobertura, capturas stale. Comando /wiki-lint como atalho.

### Episode 6: wiki_status
**Focus:** Visão operacional da wiki. Contagens, estados de fontes, atividade recente. Quando usar para diagnóstico rápido. Comando /wiki-status como atalho. Exemplos de output e como interpretar.

### Episode 7: wiki_log_event
**Focus:** Sistema de eventos estruturados. Append em meta/events.jsonl. Regeneração automática de meta/log.md. Tipos de eventos (ex: kind=integrate). Por que logging é importante para auditoria e rastreabilidade do conhecimento. Exemplos de uso no fluxo de integração.

### Episode 8: wiki_rebuild_meta
**Focus:** Rebuild completo de metadados. O que é regenerado: registry.json, backlinks.json, index.md, log.md. Quando usar: após edições manuais, após problemas de consistência. Comando /wiki-rebuild como atalho. Rebuild automático quando o modelo edita wiki/** diretamente.

### Episode 9: Arquitetura de 4 Camadas
**Focus:** As 4 camadas lógicas: Raw capture (raw/), Wiki pages (wiki/), Meta (meta/), Schema (.wiki/ + WIKI_SCHEMA.md). Como cada camada se relaciona. Fluxo de dados entre camadas. Diferença fundamental vs RAG one-shot: "a wiki that compounds."

### Episode 10: Modelo de Ownership e Guardrails
**Focus:** Tabela de ownership: quem pode editar o quê. raw/** = extension tools, imutável. wiki/** = model + user. meta/*.json = extension, gerado. Guardrails que bloqueiam edições diretas a raw/ e meta/. Por que essa separação existe. Exemplos do que acontece se tentar editar arquivo protegido.

### Episode 11: Modelo de Páginas e Citações
**Focus:** Source pages (wiki/sources/SRC-*.md) vs Canonical pages (concepts, entities, syntheses, analyses). "What does this source say?" vs "What does the wiki currently believe?" Sistema de wikilinks folder-qualified: [[concepts/rag]], [[entities/openai|OpenAI]]. Citações com IDs estáveis: [[sources/SRC-2026-04-04-001]]. Por que provenance importa.

### Episode 12: Fluxo de Integração Completo
**Focus:** O workflow end-to-end: capture source → read source page → update source page → wiki_search for impacted pages → wiki_ensure_page for missing pages → update canonical pages with citations → wiki_log_event kind=integrate. Exemplo prático completo com um artigo sendo integrado do zero.

### Episode 13: Skill Bundled e Comportamento do Modelo
**Focus:** O que a skill llm-wiki ensina ao modelo. Regras: never edit raw, metadata is machine-owned, capture first integrate second, search before creating, cite with source-page IDs, query mode read-only by default. Uso de "Tensions/caveats" e "Open questions" quando evidência é mista. Como a skill muda o comportamento do Pi.

## Execution Plan

1. Create all 13 audio overviews sequentially using `mcp__notebooklm-rpc__audio_overview_create`
2. Each with: notebook_id=`91d8e8cf-f45a-42eb-9eba-5ec995ac8223`, format=`deep_dive`, length=`long`, language=`pt-BR`
3. Poll `studio_status` after each creation to confirm completion
4. Can batch 2-3 at a time if the API allows parallel generation

## Verification
- All 13 podcasts generated successfully (studio_status = complete for each)
- Each podcast covers its specific topic with examples
- Language is pt-BR throughout
