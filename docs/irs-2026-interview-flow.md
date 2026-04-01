# IRS 2026 Interview Flow

## Objetivo

Fluxo de entrevista automática para agentes que vão apoiar o preenchimento do IRS PT 2026 antes de tocar no Portal das Finanças.

Este fluxo existe para impedir três erros frequentes:

- mexer na declaração antes de saber que anexos são realmente necessários;
- marcar IRS Jovem sem fechar a contagem dos anos relevantes;
- confundir decisão de tributação conjunta com mera informação de estado civil.

## Regra de Ouro

Antes de qualquer interação material no portal, o agente deve fechar estes quatro blocos:

1. Estrutura do agregado e regime de tributação.
2. Categorias de rendimento efetivamente existentes.
3. Elegibilidade e ano provável de IRS Jovem por titular.
4. Lista mínima de anexos necessários.

Se algum destes blocos estiver incompleto:

- o agente não deve gravar, validar, simular ou entregar;
- o agente pode, no máximo, inspecionar a declaração para recolher contexto.

## Ordem Recomendada das Perguntas

### Bloco 1. Estado civil e agregado

Perguntar:

1. Qual era o estado civil em 31/12/2025?
2. A declaração será separada ou conjunta?
3. Existem dependentes, ascendentes ou outras pessoas com impacto fiscal?

Objetivo:

- fechar o Rosto antes de qualquer leitura séria da simulação.

### Bloco 2. Rendimentos

Perguntar:

1. Que categorias de rendimento existiram em 2025?
2. Houve rendimentos no estrangeiro?
3. Houve mais-valias, rendas, capitais, atividade independente ou pensões?

Objetivo:

- determinar anexos mínimos.

### Bloco 3. Exclusões e regimes especiais

Perguntar:

1. Algum titular teve RNH?
2. Algum titular teve IFICI?
3. Algum titular teve regime fiscal de ex-residente?
4. Há deficiência, dupla tributação internacional, AIMI, pensões de alimentos ou outra exceção material?

Objetivo:

- excluir IRS Automático quando necessário;
- travar decisões erradas sobre IRS Jovem.

### Bloco 4. IRS Jovem por titular

Perguntar separadamente por cada titular:

1. Idade em 31/12/2025.
2. Primeiro ano com rendimentos A e/ou B como sujeito passivo.
3. Anos em que foi dependente.
4. Anos sem rendimentos A/B.
5. Anos dispensados de Modelo 3.
6. Se já beneficiou de IRS Jovem em anos anteriores.

Objetivo:

- determinar elegibilidade;
- contar o ano provável do benefício;
- decidir se o quadro do IRS Jovem é preenchido para um ou dois titulares.

## Regra de Contagem Prática

Para rendimentos de 2025 e seguintes, usar como regra operacional segura:

- contam os anos em que o titular teve rendimentos A/B como sujeito passivo;
- não contam anos como dependente;
- não contam anos sem rendimentos A/B;
- não contam anos dispensados de Modelo 3;
- a contagem é individual por titular, mesmo em declaração conjunta.

## Tradução da Entrevista em Decisão

### Se o caso for só categoria A em Portugal

- anexo mínimo: Anexo A;
- IRS Jovem: Quadro 4F.1 do Anexo A, por titular elegível.

### Se o caso for conjunta com dois titulares de categoria A

- anexo mínimo: um Anexo A para a declaração;
- no Quadro 4A podem existir linhas dos dois titulares;
- no Quadro 4F.1 deve existir uma linha por titular elegível.

### Se houver rendimentos do estrangeiro

- acrescentar Anexo J;
- IRS Jovem estrangeiro, se aplicável, no quadro próprio do J.

## Saída que o Agente Deve Produzir Antes de Ir ao Portal

O agente deve conseguir resumir:

- titular A: elegível ou não;
- titular B: elegível ou não;
- ano provável do benefício para cada um;
- anexos necessários;
- se a declaração está pronta para entrar no portal.

## Exemplo de Resumo Bom

- Declaração conjunta.
- Só categoria A em Portugal.
- Anexo necessário: Anexo A.
- Titular A elegível para IRS Jovem.
- Titular B elegível para IRS Jovem.
- Próximo passo no portal: Anexo A > Quadro 4 > Quadro 4F.1.
- Só depois: Validar e Simular.
