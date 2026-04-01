---
name: irs-portugal-2026
description: "Use when assisting with Portuguese IRS filing in the 2026 campaign on Portal das Finanças, including Modelo 3, IRS Automático, IRS Jovem, annex selection, validation, simulation, divergences, and official support sources. Trigger phrases: preencher IRS 2026, Portal das Finanças, Modelo 3, IRS Jovem, Anexo A, Anexo B, Anexo J, validar IRS, simular IRS, declaração de substituição, divergência IRS."
---

# IRS Portugal 2026

## Scope

Use this skill for Portugal IRS campaign 2026 work:

- campaign opened on 1 April 2026;
- usually filing 2025 income;
- Portal das Finanças form version v2026.

Primary reference for this skill:

- Read the workspace documentation in `docs/irs-2026.md` before handling non-trivial IRS cases.
- Read the MCP operational runbook in `docs/mcp-devtools-irs-2026.md` before touching a live declaration in the portal.
- Read the interview workflow in `docs/irs-2026-interview-flow.md` before asking for portal interaction on a real case.

## Hard Rules

- Prefer official AT and Diário da República sources over all other sources.
- Distinguish clearly between three states: official rule, portal-confirmed behavior, unresolved point.
- Safe operational default: if IRS Jovem is relevant, do not assume IRS Automático; use Modelo 3 manual with prefill unless the live portal proves otherwise.
- Never rely on legacy IRS Jovem rules for a 2026 filing unless the user is working on a prior-year declaration.
- Treat success in a live declaration only as: `Validar` runs clean enough to proceed and `Simular` is opened at the end for the user.
- Until that point, the agent should stay in correction mode: inspect errors, fix the declaration, save if needed, and validate again.
- Never submit a real declaration without explicit user confirmation.
- Never add or remove annexes in a real authenticated return just to test navigation.
- Never store or echo taxpayer personal data in persistent notes.

## Official Source Order

1. CIRS and consolidated law.
2. Current AT service pages.
3. Current annex instructions and circulars.
4. Internal help inside the v2026 form.
5. FAQs, folhetos, videos, e-balcão and CAT.

Core URLs:

- IRS campaign: https://info.portaldasfinancas.gov.pt/pt/apoio_contribuinte/IRS/Pages/default.aspx
- Modelo 3: https://info.portaldasfinancas.gov.pt/pt/apoio_ao_contribuinte/Cidadaos/Rendimentos/Declaracao/Modelo_3/Paginas/default.aspx
- IRS Automático: https://info.portaldasfinancas.gov.pt/pt/apoio_ao_contribuinte/Cidadaos/Rendimentos/Declaracao/IRS_automatico/Paginas/default.aspx
- IRS Jovem legal rule: https://info.portaldasfinancas.gov.pt/pt/informacao_fiscal/codigos_tributarios/cirs_rep/Pages/irs12b.aspx
- e-balcão: https://sitfiscal.portaldasfinancas.gov.pt/ebalcao/home

## Diagnostic Workflow

Always ask enough questions to determine:

1. Residency and tax status in 2025.
2. Marital status and joint vs separate filing.
3. Dependents, ascendants, and special family situations.
4. Income categories present: A, B, E, F, G, H, I, J, L, SS implications.
5. Foreign income and foreign tax paid.
6. Potential IRS Jovem eligibility.
7. Any exclusion from IRS Automático.
8. Any special regime or edge case.

Interview rule:

- Ask only one short, decision-relevant question at a time when the facts are still incomplete.
- Do not jump into the portal until marital regime, income categories, exclusions, and IRS Jovem history are closed.
- In joint filing, treat taxpayer A and taxpayer B as separate IRS Jovem timelines.

Minimum IRS Jovem questions:

1. Age on 31/12/2025.
2. First year with category A or B income as a taxpayer.
3. Years as dependent.
4. Years without A/B income.
5. Years dispensed from Modelo 3.
6. Any prior IRS Jovem use.
7. Any prior RNH, IFICI, or article 12.º-A use.
8. Whether tax status is regularized.

Minimum pre-portal closed set:

1. Joint or separate filing.
2. Required annexes.
3. IRS Jovem eligibility by taxpayer.
4. Probable benefit year by taxpayer.

## Portal Navigation Notes

Observed in the authenticated v2026 portal session:

- Initial assistant modes: prefilled declaration, read from saved file, use last submitted declaration, create empty declaration.
- Initial assistant fields: income year, taxpayer A NIF, joint taxation option.
- Main action buttons: Gravar, Validar, Simular, Ajudas, Imprimir, Entregar.
- Attachments panel: Rosto plus Anexos with Add Anexo.
- Add Anexo list: A, B, C, D, E, F, G, G1, H, I, J, L, SS.

Operational note confirmed from the live client help:

- In Anexo A help, `Quadro 4F.1` is explicitly described as `Opção pelo regime fiscal do art.º 12.º-B do CIRS - IRS Jovem - anos de 2025 e seguintes`.
- The same help states that eligible taxpayers must declare category A income in Quadro 4A with codes `401`, `412`, `413`, `414`, `415`, `416` and/or `419`, then mark `Sim` or `Não` in Quadro 4F.1.
- Code `417` remains tied to the legacy 2020-2024 IRS Jovem block and must not be used as the 2025+ rule by default.

Preferred navigation order:

1. Open the prefilled declaration unless the user asks for a different mode.
2. Review Rosto first.
3. Add only the annexes justified by actual income or tax facts.
4. Use Ajudas when a field or code is unclear.
5. Run `Validar`, fix what blocks the declaration, and repeat until validation is usable.
6. Only then run `Simular` and present the calculation result as the last step before success.
7. Stop before Entregar and obtain explicit approval.

## MCP DevTools Workflow

When operating on a live declaration with browser automation:

1. Confirm the selected page is the IRS page, not `autenticacao.gov.pt`.
2. Re-open `https://irs.portaldasfinancas.gov.pt/app/entrega/v2026#!` if the session drifted.
3. Take a snapshot before any interaction.
4. Open the declaration with prefill, year `2025`, taxpayer A NIF, and the user-approved joint/separate choice.
5. Close the startup wizard once the declaration has loaded behind it.
6. Review `Rosto` before editing annexes.
7. Open `Anexos` and only add annexes justified by the case.
8. For category A cases, go through Anexo A and check Quadro 4A plus Quadro 4F.1.
9. Run `Validar`, parse every blocking error, and return to the relevant quadro to correct it.
10. Repeat `Validar -> corrigir -> gravar` until the declaration no longer has blocking errors for simulation.
11. Run `Simular` only at the end and present the calculation result to the user.
12. Stop before `Entregar` and ask for explicit approval.

Pre-portal gate:

- If the interview is incomplete, the agent may inspect but must not make material declaration changes.
- Material changes include adding IRS Jovem lines, changing filing regime, changing annex selection, validating, simulating, or submitting.

Live correction loop:

- Do not stop at a partially prepared declaration if the user asked for an end-to-end filing assist.
- If `Validar` raises errors, the next action is to fix those errors, not to summarize prematurely.
- If the floating error panel appears stale after edits, treat it as non-authoritative until `Validar` is run again.
- The declaration is only operationally ready when validation works and the simulation result is visible.

If the live page redirects to authentication:

- stop portal actions;
- ask the user to complete login;
- reselect the IRS page and continue.

## IRS Jovem Rules

For 2025 income and later, treat IRS Jovem as the current regime:

- up to age 35;
- not a dependent;
- up to 10 years of A/B income as a taxpayer;
- annual option in the declaration;
- 100% / 75% / 50% / 25% phases;
- 55 IAS cap;
- excluded if the taxpayer benefited from RNH, IFICI, or article 12.º-A, or lacks a regularized tax situation.

Operational placement by annex:

- Anexo A: quadro 4F.1, answer Sim/Não.
- Anexo B: quadro 3E.1, answer Sim/Não.
- Anexo J: quadro 4E.1, answer Sim/Não for foreign employment income.
- Anexos C and D: dedicated IRS Jovem areas confirmed by Ofício-Circulado 20278/2025.

Important portal note:

- The internal help inside the v2026 form still contains a legacy IRS Jovem block for 2020-2024 and a current block for 2025 onwards.
- For campaign 2026, anchor decisions on the "Anos de 2025 seguintes" block, unless the user is explicitly working on a prior-year declaration.
- In live category A work, the agent should cross-check Quadro 4A codes and Quadro 4F.1 together; marking IRS Jovem without the correct category A income coding is unsafe.

## Response Pattern

When answering the user, prefer this structure:

1. Fechado.
2. A validar no portal.
3. Próxima ação recomendada.

When working inside the live portal, also summarize:

- annexes currently needed;
- whether IRS Jovem should be marked;
- whether the IRS Jovem assessment applies to one or both taxpayers in joint filing;
- the probable benefit year for each eligible taxpayer;
- whether the declaration is still in correction mode or has passed validation;
- what validation/simulation still needs to be run;
- what the user must confirm before submission.

Success line for live cases:

- Do not describe the case as successful while `Validar` still reports blocking errors.
- The last step before success is the simulation screen or calculator shown to the user.

## Escalation Rules

Escalate to official support or ask for user confirmation when:

- the portal behavior conflicts with the current rule set;
- IRS Jovem year counting is ambiguous;
- the case mixes foreign income, article 12.º-A, IFICI, RNH, or unusual annex combinations;
- Anexo SS obligations are unclear;
- the user asks to submit a return without prior validation and simulation.