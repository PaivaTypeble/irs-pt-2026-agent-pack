# MCP DevTools Runbook For IRS 2026

## Objetivo

Runbook operacional para agentes que usam MCP DevTools ou browser automation no preenchimento do IRS PT 2026 no Portal das Finanças.

Este runbook assume:

- sessão real do contribuinte;
- navegação no formulário v2026;
- necessidade de minimizar alterações antes da validação final;
- proibição de entrega sem confirmação expressa do utilizador.

## Regras de Segurança

- Nunca entregar a declaração sem confirmação explícita.
- Nunca gravar alterações irreversíveis só para testar a interface.
- Nunca adicionar ou remover anexos sem justificação material.
- Nunca confiar no pré-preenchimento sem revisão.
- Nunca assumir IRS Automático quando IRS Jovem seja relevante.
- Nunca persistir dados pessoais do contribuinte em memória permanente.
- Nunca tratar "pronto para validar" como estado final quando o pedido é end-to-end; o fim operacional é `Validar` sem bloqueios materiais e `Simular` aberto.

## Sequência de Ferramentas

Quando disponíveis, a sequência recomendada no MCP DevTools é:

1. Abrir ou selecionar a página do IRS.
2. Navegar para o formulário v2026.
3. Tirar snapshot acessível da página.
4. Se o serviço redirecionar para autenticação, parar e pedir ao utilizador para concluir login.
5. Só depois interagir com o assistente inicial ou com a declaração.
6. Usar `evaluate_script` para ler estado e `fill` para campos simples.
7. Usar `take_snapshot` após mudanças estruturais.
8. Usar `list_console_messages` apenas para detetar falhas do cliente.

## Passo A Passo

### 1. Abrir a sessão certa

1. Confirmar que a página selecionada é a do IRS e não a do Autenticação.gov.
2. Se necessário, navegar para `https://irs.portaldasfinancas.gov.pt/app/entrega/v2026#!`.
3. Confirmar no snapshot que o título é `IRS` e que existe o cabeçalho `Preencher Declaração`.

Resultado esperado:

- página do IRS aberta;
- sessão autenticada ativa;
- sem submissões nem gravações feitas.

### 2. Lidar com autenticação

Se surgir `Autenticação.gov`:

1. Parar interações de preenchimento.
2. Pedir ao utilizador para concluir o login.
3. Voltar a selecionar a página do IRS.
4. Repetir snapshot antes de prosseguir.

### 3. Abrir a declaração em modo seguro

Modo preferencial:

- `Obtenção de uma declaração pré-preenchida`.

Campos observados no assistente inicial:

- Ano dos Rendimentos.
- NIF do Sujeito Passivo A.
- Opção Pela Tributação Conjunta dos Rendimentos.

Sequência:

1. Selecionar pré-preenchimento.
2. Definir ano de 2025.
3. Preencher NIF do sujeito passivo A.
4. Marcar ou não a tributação conjunta conforme decisão do utilizador.
5. Continuar.
6. Fechar o assistente inicial se estiver a sobrepor-se ao formulário já carregado.

### 4. Rever o Rosto antes dos anexos

Ordem mínima de revisão:

1. Serviço de Finanças da área do domicílio fiscal.
2. Ano dos rendimentos.
3. Nome do sujeito passivo.
4. Estado civil.
5. Opção pela tributação conjunta.
6. Agregado familiar.
7. Residência fiscal.
8. Natureza da declaração.

Se o estado civil ou o agregado estiverem errados:

- não avançar para simulação final;
- corrigir primeiro o Rosto;
- revalidar só depois.

### 5. Determinar anexos por factos, não por hábito

Regras práticas:

- Só categoria A em Portugal: Anexo A.
- Categoria B simplificada: Anexo B.
- Categoria B organizada: Anexo C.
- Transparência fiscal ou imputação: Anexo D.
- Capitais: Anexo E.
- Prediais: Anexo F.
- Mais-valias: Anexo G ou G1.
- Rendimentos do estrangeiro: Anexo J.
- Situações residuais de RNH/IFICI: Anexo L.
- Independentes com obrigação contributiva: Anexo SS.
- Anexo H apenas quando for necessário declarar manualmente deduções, benefícios ou correções que não ficam assumidas pela AT.

### 6. Abrir o painel de anexos

1. Abrir `Anexos`.
2. Ver o que já existe.
3. Só usar `Adicionar Anexo` quando o facto tributário o justificar.

Lista observada no portal v2026:

- A, B, C, D, E, F, G, G1, H, I, J, L, SS.

### 7. Fluxo específico para categoria A

Quando o contribuinte só tem trabalho dependente:

1. Garantir que o Anexo A existe.
2. Rever o quadro 4 do Anexo A.
3. Confirmar códigos de rendimento pré-preenchidos.
4. Rever retenções, contribuições e despesas declarativas relevantes.

Na ajuda interna do cliente v2026, o quadro 4 do Anexo A confirma:

- códigos 401, 412, 413, 414, 415, 416 e 419 como relevantes para IRS Jovem em 2025 e seguintes;
- código 417 como referência do regime antigo para anos de 2020 a 2024.

### 8. Fluxo específico para IRS Jovem

Para rendimentos de 2025 e seguintes:

1. Confirmar elegibilidade material.
2. Não usar regras antigas do bloco 2020-2024.
3. No Anexo A, ir ao `Quadro 4F.1 - Opção pelo regime fiscal do art.º 12.º-B do CIRS - IRS Jovem - anos de 2025 e seguintes`.
4. Assinalar `Sim` ou `Não` conforme decisão do sujeito passivo elegível.
5. Garantir que no quadro 4A os rendimentos elegíveis estão declarados com os códigos corretos.
6. Repetir a análise para o outro sujeito passivo se a declaração for conjunta e ambos forem potencialmente elegíveis.

Critérios que a ajuda do cliente v2026 confirma para 2025 e seguintes:

- idade até 35 anos no ano da declaração;
- não dependente;
- não mais de 10 anos de rendimentos A/B como sujeito passivo;
- sem RNH;
- sem IFICI;
- sem artigo 12.º-A;
- situação tributária regularizada.

### 9. Decidir entre separada e conjunta

Se o utilizador for casado ou unido de facto:

1. Confirmar se quer tributação conjunta ou separada.
2. Confirmar se o cônjuge também teve rendimentos.
3. Em conjunta, confirmar se ambos precisam de IRS Jovem ou apenas um.
4. Só depois fixar a leitura final da simulação.

### 10. Validar e simular

Ordem obrigatória:

1. `Validar`.
2. Ler cada erro de bloqueio e mapear o quadro de origem.
3. Corrigir a declaração no quadro certo.
4. `Gravar` quando a alteração o justificar.
5. `Validar` novamente.
6. Repetir até a declaração deixar de ter bloqueios materiais para simulação.
7. `Simular` no fim.
8. Rever impacto esperado de IRS Jovem, retenções, deduções e tributação conjunta/separada.

Se houver diferença inesperada:

- não entregar;
- rever Rosto, anexos e quadro de IRS Jovem;
- usar ajuda interna e fontes oficiais.

Notas operacionais da sessão real:

- O painel flutuante de erros pode ficar com mensagens antigas visíveis mesmo depois de corrigido um quadro; o estado fiável volta a ser o resultado do `Validar` seguinte.
- Em páginas longas com vários `Adicionar Linha`, o alvo deve ser sempre identificado por secção antes do clique.

### 11. Entrega

Só depois de:

- anexos corretos;
- IRS Jovem corretamente assinalado;
- validação sem bloqueios materiais;
- simulação coerente;
- aprovação expressa do utilizador.

## Perfis de Decisão Rápida

### Perfil A: solteiro, só categoria A, sem estrangeiro

- Rosto + Anexo A.
- IRS Jovem no Quadro 4F.1 do Anexo A se elegível.
- Sem Anexo J, B, C, D, E, F, G, L ou SS.

### Perfil B: casado, conjunta, ambos com categoria A

- Rosto + Anexo A.
- No Anexo A, declarar rendimentos dos titulares corretos.
- Rever IRS Jovem para cada sujeito passivo elegível.

### Perfil C: categoria A + estrangeiro

- Rosto + Anexo A + Anexo J.
- IRS Jovem doméstico no A e estrangeiro no J, conforme aplicável.

### Perfil D: independente

- Rosto + B ou C.
- Avaliar SS.
- IRS Jovem nos quadros próprios de B/C se elegível.

## Observações úteis da sessão real de 1 de abril de 2026

- O cliente v2026 carrega a ajuda interna do Anexo A no browser.
- A ajuda do Anexo A confirma explicitamente o `Quadro 4F.1` para IRS Jovem em 2025 e seguintes.
- A mesma ajuda mantém o bloco antigo para 2020-2024, pelo que o agente deve distinguir rigorosamente os dois regimes.
- Num caso real com apenas categoria A declarada pelo utilizador, o anexo materialmente esperado é o Anexo A.

## Checklist Final Para o Agente

- Sessão certa aberta.
- Autenticação confirmada.
- Declaração v2026 aberta por pré-preenchimento.
- Rosto revisto.
- Anexos justificados pelo caso.
- IRS Jovem decidido com base em regra atual.
- Quadro certo localizado.
- Validação executada sem bloqueios materiais pendentes.
- Simulação executada e mostrada ao utilizador no fim.
- Sem entrega sem aprovação do utilizador.
