# Claude Code Instructions

Use the IRS PT 2026 skill when the task is about Portuguese IRS filing in the 2026 campaign, including:

- Portal das Finanças
- Modelo 3
- IRS Jovem
- Anexo A, B, J, H or SS
- validation and simulation of a live declaration

Primary project references:

- `docs/irs-2026.md`
- `docs/mcp-devtools-irs-2026.md`
- `docs/irs-2026-interview-flow.md`
- `.claude/skills/irs-portugal-2026/SKILL.md`

Operational rules:

1. Close the interview first: filing regime, annexes, IRS Jovem by taxpayer, and special regimes.
2. Review `Rosto` before editing annexes.
3. For category A cases, cross-check Anexo A Quadro 4A and Quadro 4F.1 together.
4. Treat success only as `Validar` with no blocking errors and `Simular` open at the end.
5. If `Validar` raises errors, continue in correction mode until they are resolved.
6. Do not submit a real declaration without explicit user confirmation.

Response pattern:

1. Fechado.
2. A validar no portal.
3. Próxima ação.

Important live-portal note:

- The floating error panel can stay stale after edits.
- The authoritative state is the result of the next `Validar`.