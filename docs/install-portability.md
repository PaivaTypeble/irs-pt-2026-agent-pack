# Instalar e Reutilizar a Skill IRS PT 2026

## Estado atual

Os artefactos principais já estão atualizados neste workspace:

- skill: `.github/skills/irs-portugal-2026/SKILL.md`
- agent: `.github/agents/preencher-irs-pt-2026.agent.md`
- prompt: `.github/prompts/preencher-irs-pt-2026.prompt.md`
- Claude skill equivalente: `.claude/skills/irs-portugal-2026/SKILL.md`
- Claude project instructions equivalentes ao agent: `CLAUDE.md`
- instaladores: `scripts/install-irs-pt-2026.ps1` e `scripts/install-irs-pt-2026.sh`
- instaladores por URL: `scripts/bootstrap-install.ps1` e `scripts/bootstrap-install.sh`
- build do template: `scripts/build-template.ps1` e `scripts/build-template.sh`
- publicação do template: `scripts/publish-template.ps1` e `scripts/publish-template.sh`
- criação de release: `scripts/create-release.ps1` e `scripts/create-release.sh`
- convenção de versionamento/releases: `docs/release-versioning.md`
- documentação de apoio: `docs/irs-2026.md`, `docs/mcp-devtools-irs-2026.md`, `docs/irs-2026-interview-flow.md`

## Limite de confidencialidade

Se distribuires isto como ficheiros locais, zip, release asset ou repositório, quem recebe pode inspecionar o conteúdo.

Isto inclui:

- download por link;
- zip interno;
- GitHub release;
- repositório template;
- script de instalação que copia ficheiros.

Portanto:

- sim, existe forma de alguém instalar isto facilmente a partir de um link;
- não, não existe forma séria de garantir que essa pessoa não saiba o que está escrito se os ficheiros ficarem na máquina dela.

Se o objetivo for ocultar a lógica interna, a solução deixa de ser distribuição de skill/agent local e passa a ser serviço remoto privado.

## Instalação direta por link

PowerShell:

```powershell
irm https://github.com/PaivaTypeble/irs-pt-2026-agent-pack/releases/latest/download/bootstrap-install.ps1 | iex
```

Shell:

```bash
curl -fsSL https://github.com/PaivaTypeble/irs-pt-2026-agent-pack/releases/latest/download/bootstrap-install.sh | sh
```

Comportamento por omissão:

- instala no diretório atual;
- instala em modo `both`.

Variáveis opcionais:

- `IRS_PT_2026_MODE`
- `IRS_PT_2026_DESTINATION`
- `IRS_PT_2026_REPO`
- `IRS_PT_2026_ASSET`

Para versionamento e release notes, ver também `docs/release-versioning.md`.

## O que é portável e o que não é

### 1. Skill

O conteúdo da skill é portável.

Pode viver em:

- GitHub Copilot / VS Code workspace: `.github/skills/irs-portugal-2026/SKILL.md`
- Claude-style project skills: `.claude/skills/irs-portugal-2026/SKILL.md`

### 2. Agent

O ficheiro `.agent.md` é um artefacto de customização do ecossistema GitHub Copilot / VS Code.

Pode ser reutilizado em:

- outro workspace VS Code com Copilot Chat: `.github/agents/preencher-irs-pt-2026.agent.md`
- perfil pessoal VS Code: pasta de prompts do utilizador

Não deve ser assumido como instalável `as-is` em Claude Code.

Para Claude Code, a regra prática é:

- reutilizar a `SKILL.md`;
- migrar a lógica do agent para instruções de projeto ou para um comando/prompt equivalente do ambiente Claude;
- não contar com suporte nativo ao formato `.agent.md` do Copilot.

### 3. Prompt

O `.prompt.md` é reutilizável no ecossistema GitHub Copilot / VS Code.

Em Claude Code, deve ser tratado como texto-base para um comando/prompt próprio, não como ficheiro automaticamente reconhecido com a mesma semântica.

## Instalar noutro workspace GitHub Copilot / VS Code

Forma recomendada:

```powershell
.
\scripts\install-irs-pt-2026.ps1 -Destination "C:\caminho\para\outro-repo" -Mode copilot
```

ou, em shell:

```bash
./scripts/install-irs-pt-2026.sh /caminho/para/outro-repo copilot
```

Copiar estes blocos para o novo repositório:

- `.github/skills/irs-portugal-2026/SKILL.md`
- `.github/agents/preencher-irs-pt-2026.agent.md`
- `.github/prompts/preencher-irs-pt-2026.prompt.md`
- `docs/irs-2026.md`
- `docs/mcp-devtools-irs-2026.md`
- `docs/irs-2026-interview-flow.md`

Estrutura mínima recomendada no destino:

```text
.github/
  agents/
    preencher-irs-pt-2026.agent.md
  prompts/
    preencher-irs-pt-2026.prompt.md
  skills/
    irs-portugal-2026/
      SKILL.md
docs/
  irs-2026.md
  mcp-devtools-irs-2026.md
  irs-2026-interview-flow.md
```

### Exemplo PowerShell

```powershell
$src = "C:\Users\luisp\Documents\IRS-SKILL"
$dst = "C:\caminho\para\outro-repo"

New-Item -ItemType Directory -Force -Path "$dst\.github\skills\irs-portugal-2026" | Out-Null
New-Item -ItemType Directory -Force -Path "$dst\.github\agents" | Out-Null
New-Item -ItemType Directory -Force -Path "$dst\.github\prompts" | Out-Null
New-Item -ItemType Directory -Force -Path "$dst\docs" | Out-Null

Copy-Item "$src\.github\skills\irs-portugal-2026\SKILL.md" "$dst\.github\skills\irs-portugal-2026\SKILL.md" -Force
Copy-Item "$src\.github\agents\preencher-irs-pt-2026.agent.md" "$dst\.github\agents\preencher-irs-pt-2026.agent.md" -Force
Copy-Item "$src\.github\prompts\preencher-irs-pt-2026.prompt.md" "$dst\.github\prompts\preencher-irs-pt-2026.prompt.md" -Force
Copy-Item "$src\docs\irs-2026.md" "$dst\docs\irs-2026.md" -Force
Copy-Item "$src\docs\mcp-devtools-irs-2026.md" "$dst\docs\mcp-devtools-irs-2026.md" -Force
Copy-Item "$src\docs\irs-2026-interview-flow.md" "$dst\docs\irs-2026-interview-flow.md" -Force
```

## Instalar no teu perfil pessoal VS Code

No VS Code, os artefactos pessoais rodam melhor assim:

- agent e prompt: na pasta pessoal do utilizador
- skill: continuar por workspace, porque skills não usam a mesma pasta pessoal dos prompts

Pasta pessoal do utilizador neste ambiente:

- `C:\Users\luisp\AppData\Roaming\Code\User\prompts`

Podes copiar para aí:

- `preencher-irs-pt-2026.agent.md`
- `preencher-irs-pt-2026.prompt.md`

Mas a `SKILL.md` deve continuar no repositório onde queres usá-la.

Conclusão prática:

- se queres reutilização total, usa um repo-template ou um script de cópia;
- se queres só o comando e o agente em todos os workspaces, instala o agent e o prompt no perfil, e replica a skill por workspace.

## Instalar em Claude Code

Forma recomendada:

```powershell
.
\scripts\install-irs-pt-2026.ps1 -Destination "C:\caminho\para\projeto-claude" -Mode claude
```

ou, em shell:

```bash
./scripts/install-irs-pt-2026.sh /caminho/para/projeto-claude claude
```

### Opção segura

Copiar apenas a skill para a pasta de skills do projeto:

```text
.claude/
  skills/
    irs-portugal-2026/
      SKILL.md
```

e também o equivalente ao agent:

```text
CLAUDE.md
```

Depois copiar também a documentação de apoio:

- `docs/irs-2026.md`
- `docs/mcp-devtools-irs-2026.md`
- `docs/irs-2026-interview-flow.md`

### O que fazer com o agent

O conteúdo do agent deve ser convertido para o mecanismo local do Claude Code, por exemplo:

- instrução de projeto;
- comando de slash próprio;
- prompt reutilizável;
- workflow documentado no `CLAUDE.md` ou equivalente do projeto.

Resumo curto:

- `SKILL.md`: sim, portável;
- `.agent.md`: não assumir compatibilidade direta;
- `CLAUDE.md`: é o equivalente operacional criado neste repo para Claude Code;
- `.prompt.md`: reutilizável como base textual, mas não necessariamente como formato nativo.

## Melhor forma de distribuição

Se quiseres instalar isto em muitos projetos, a forma mais limpa é uma destas:

1. Repo-template com estes ficheiros já preparados.
2. Script de bootstrap que copia os ficheiros certos para o projeto alvo.
3. Um pacote interno com duas variantes:
   - `copilot/` para `.github/...`
   - `claude/` para `.claude/skills/...` e instruções equivalentes.

## Gerar o repo-template limpo

```powershell
.\scripts\build-template.ps1
```

ou:

```bash
./scripts/build-template.sh
```

Resultado:

- `dist/irs-pt-2026-template/`
- `dist/irs-pt-2026-template.zip` ou `dist/irs-pt-2026-template.tar.gz`

## Publicar para um repositório de templates

Se já tens um repositório remoto:

```powershell
.\scripts\publish-template.ps1 -RemoteUrl "git@github.com:OWNER/REPO.git"
```

Se quiseres que o script crie o repositório via GitHub CLI e tente marcá-lo como template:

```powershell
.\scripts\publish-template.ps1 -GitHubRepo "OWNER/REPO"
```

Em shell:

```bash
./scripts/publish-template.sh git@github.com:OWNER/REPO.git
```

## Criar release com zip público

PowerShell:

```powershell
.\scripts\create-release.ps1 -GitHubRepo "OWNER/REPO" -Latest
```

Shell:

```bash
./scripts/create-release.sh OWNER/REPO
```

## Recomendação prática

Para não depender de instalação manual repetida:

1. Mantém este repositório como fonte de verdade.
2. Usa `scripts/install-irs-pt-2026.ps1` ou `scripts/install-irs-pt-2026.sh` para instalar noutros projetos.
3. Para Claude Code, instala a `SKILL.md` e o `CLAUDE.md` equivalente.
4. Usa `scripts/build-template.ps1` para gerar um export limpo e `scripts/publish-template.ps1` para publicar num repositório template.