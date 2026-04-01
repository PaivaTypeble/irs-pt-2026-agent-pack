# IRS PT 2026 Agent Pack

Pacote de distribuição para apoio ao preenchimento do IRS português na campanha de 2026.

Inclui variantes para:

- GitHub Copilot / VS Code
- Claude Code

## Conteúdo

- skill IRS PT 2026 para Copilot
- agent e prompt para Copilot
- skill equivalente para Claude
- instruções de projeto para Claude
- documentação operacional e de entrevista
- scripts de instalação, build e publicação

## Regra operacional central

O fluxo correto não termina em "pronto para validar".

Sucesso operacional significa:

1. `Validar` sem erros bloqueantes.
2. `Simular` aberto no fim.

Até lá, o agente deve continuar em modo de correção.

## Instalação rápida

### Instalação por link

PowerShell, no diretório do projeto alvo:

```powershell
irm https://raw.githubusercontent.com/PaivaTypeble/irs-pt-2026-agent-pack/main/scripts/bootstrap-install.ps1 | iex
```

Shell, no diretório do projeto alvo:

```bash
curl -fsSL https://raw.githubusercontent.com/PaivaTypeble/irs-pt-2026-agent-pack/main/scripts/bootstrap-install.sh | sh
```

Variáveis opcionais:

- `IRS_PT_2026_MODE`: `copilot`, `claude` ou `both`
- `IRS_PT_2026_DESTINATION`: destino da instalação
- `IRS_PT_2026_REPO`: outro repositório GitHub de distribuição
- `IRS_PT_2026_ASSET`: nome do asset do release

### Copilot / VS Code

```powershell
.\scripts\install-irs-pt-2026.ps1 -Destination "C:\caminho\para\repo" -Mode copilot
```

### Claude Code

```powershell
.\scripts\install-irs-pt-2026.ps1 -Destination "C:\caminho\para\repo" -Mode claude
```

### Ambos

```powershell
.\scripts\install-irs-pt-2026.ps1 -Destination "C:\caminho\para\repo" -Mode both
```

## Build do template limpo

```powershell
.\scripts\build-template.ps1
```

Isto gera:

- `dist\irs-pt-2026-template\`
- `dist\irs-pt-2026-template.zip`

## Publicar para um repositório GitHub

Se o repositório já existir:

```powershell
.\scripts\publish-template.ps1 -RemoteUrl "git@github.com:OWNER/REPO.git"
```

Se quiseres que o script crie e marque o repo como template via GitHub CLI:

```powershell
.\scripts\publish-template.ps1 -GitHubRepo "OWNER/REPO"
```

## Criar release pública com zip

```powershell
.\scripts\create-release.ps1 -GitHubRepo "OWNER/REPO" -Latest
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
- `docs/irs-2026.md`
- `docs/mcp-devtools-irs-2026.md`
- `docs/irs-2026-interview-flow.md`