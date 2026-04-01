# Convenção de Versionamento e Releases

## Objetivo

Manter o pack público instalável por `releases/latest/download/...` com regras simples e repetíveis.

## Formato da versão

- formato base: `vYYYY.MM.DD`
- exemplo: `v2026.04.01`
- o script `scripts/create-release.ps1` usa este formato por omissão

## Quando atualizar a mesma tag

Atualizar a mesma tag no mesmo dia quando a mudança for uma destas:

- correção de packaging
- correção de documentação
- troca de assets do release sem mudança funcional do pack

## Quando criar nova tag

Criar nova tag quando houver pelo menos uma destas mudanças:

- novo comportamento funcional do skill, agent, prompt ou instruções Claude
- alteração das regras operacionais do fluxo IRS
- novo ficheiro obrigatório no pack
- mudança que altere o modo de instalação ou publicação

Se precisares de mais do que uma release pública no mesmo dia, usar `-Tag` manualmente, por exemplo:

- `v2026.04.01.1`
- `v2026.04.01.2`

## Ordem mínima da release

1. Atualizar documentação e scripts.
2. Correr `scripts/build-template.ps1`.
3. Publicar `main` com `scripts/publish-template.ps1 -GitHubRepo "OWNER/REPO" -ForcePush`.
4. Criar ou atualizar a release com `scripts/create-release.ps1 -GitHubRepo "OWNER/REPO" -Latest`.
5. Testar pelo menos um bootstrap a partir do URL do release.

## Checklist antes de marcar latest

- README alinhado com os comandos reais
- assets do release presentes: zip e bootstraps
- instalação por link validada
- instalação com destino explícito validada
- nenhuma referência crítica ainda dependente de raw branch URL

## Estrutura mínima das release notes

Cada release pública deve documentar estes blocos:

- Scope
- Changed
- Validation
- Operational impact
- Known limits

## Template de release notes

```md
## Scope

O que esta release altera.

## Changed

- item 1
- item 2

## Validation

- build do template executado
- release asset atualizado
- smoke test do bootstrap executado

## Operational impact

- impacto para quem instala
- impacto para quem mantém

## Known limits

- limite 1
- limite 2
```