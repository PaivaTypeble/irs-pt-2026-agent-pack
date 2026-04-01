# IRS PT 2026 Agent Pack

Pacote público para instalar a automação IRS PT 2026 em GitHub Copilot / VS Code e Claude Code.

Inclui:

- skill, agent e prompt para Copilot
- skill e instruções equivalentes para Claude
- documentação operacional para entrevista, preenchimento, validação e simulação
- scripts de instalação, build, publicação e release

## Regra central

Sucesso operacional = `Validar` sem erros bloqueantes + `Simular` aberto no fim.

## Instalação rápida

PowerShell, no diretório do projeto alvo:

```powershell
irm https://github.com/PaivaTypeble/irs-pt-2026-agent-pack/releases/latest/download/bootstrap-install.ps1 | iex
```

Shell, no diretório do projeto alvo:

```bash
curl -fsSL https://github.com/PaivaTypeble/irs-pt-2026-agent-pack/releases/latest/download/bootstrap-install.sh | sh
```

Por omissão:

- instala no diretório atual
- instala em modo `both`

Variáveis opcionais:

- `IRS_PT_2026_MODE`: `copilot`, `claude` ou `both`
- `IRS_PT_2026_DESTINATION`: destino da instalação
- `IRS_PT_2026_REPO`: outro repositório GitHub de distribuição
- `IRS_PT_2026_ASSET`: nome do asset do release

## Instalação local

PowerShell:

```powershell
\.\scripts\install-irs-pt-2026.ps1 -Destination "C:\caminho\para\repo" -Mode both
```

Shell:

```bash
./scripts/install-irs-pt-2026.sh /caminho/para/repo both
```

`Mode` aceita `copilot`, `claude` ou `both`.

## Manutenção

Build do template limpo:

```powershell
\.\scripts\build-template.ps1
```

Publicação para o repositório template:

```powershell
\.\scripts\publish-template.ps1 -GitHubRepo "OWNER/REPO" -ForcePush
```

Release pública:

```powershell
\.\scripts\create-release.ps1 -GitHubRepo "OWNER/REPO" -Latest
```

## Limite importante sobre visibilidade

Se alguém instala isto como ficheiros locais, zip ou repositório, essa pessoa pode inspecionar o conteúdo.

Não existe forma séria de garantir "instalação sem ver o que está escrito" quando os artefactos vivem localmente na máquina de quem instala.

Se precisas de ocultação real, a arquitetura certa deixa de ser distribuição de ficheiros e passa a ser:

- serviço remoto privado;
- MCP privado;
- backend controlado por ti;
- cliente local sem acesso à lógica interna.

## Referência

Ver também:

- `docs/install-portability.md`
- `docs/release-versioning.md`
- `docs/irs-2026.md`
- `docs/mcp-devtools-irs-2026.md`
- `docs/irs-2026-interview-flow.md`