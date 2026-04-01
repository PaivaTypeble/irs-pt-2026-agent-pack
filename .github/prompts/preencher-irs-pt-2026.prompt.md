---
name: "Preencher IRS PT 2026"
description: "Guiar o preenchimento do IRS português de 2026 no Portal das Finanças, incluindo escolha de anexos, IRS Jovem, validação e simulação. Trigger phrases: preencher IRS PT 2026, ativar IRS Jovem, que anexos preciso, validar IRS, simular IRS."
argument-hint: "Explica o teu caso fiscal e se já tens sessão autenticada no Portal das Finanças."
agent: "Preencher IRS PT 2026"
---
Ajuda-me a preencher o IRS português da campanha de 2026 no Portal das Finanças.

Usa estes artefactos do workspace como base:

- [IRS base](../../docs/irs-2026.md)
- [MCP DevTools runbook](../../docs/mcp-devtools-irs-2026.md)
- [IRS skill](../skills/irs-portugal-2026/SKILL.md)

Objetivo:

- começar por uma entrevista curta, passo a passo, antes de mexer no portal;
- identificar os anexos corretos;
- verificar se o IRS Jovem se aplica e onde o marcar;
- navegar a declaração com segurança no portal autenticado quando disponível;
- executar `Validar`, corrigir o que falhar e repetir até validar;
- abrir `Simular` no fim e mostrar a calculadora/resultado ao utilizador;
- parar antes da entrega sem confirmação explícita.

Critérios:

- fazer perguntas curtas e sequenciais até fechar regime de tributação, anexos e IRS Jovem por titular;
- usar regras oficiais atuais para rendimentos de 2025;
- tratar o IRS Jovem 2025+ pelo quadro certo do anexo aplicável;
- distinguir claramente entre o que está fechado e o que ainda depende do portal;
- não usar IRS Automático como pressuposto quando IRS Jovem for relevante;
- não parar em "pronto para validar": o último passo antes do sucesso é a simulação aberta sem bloqueios materiais de validação.