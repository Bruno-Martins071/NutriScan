# Requisitos e Funcionalidades: NutriScan

## 2.1 Funcionalidades

As funcionalidades abaixo partem do estudo de caso, das personas e da pesquisa. O fluxo principal acontece no supermercado: a pessoa aponta a câmera, recebe o semáforo e decide se leva o produto. Por isso, não há cadastro de conta nem dependência de internet na consulta principal. Nutricionistas e médicos ficam fora desta lista, porque são público secundário.

### F01 Perfil de restrições alimentares

**Descrição:** O usuário informa quais alergias, intolerâncias ou restrições alimentares possui, como glúten, lactose, amendoim e soja. Essas informações ficam salvas no próprio celular.

**Necessidade atendida:** Ter as restrições reconhecidas automaticamente em cada leitura, sem digitá-las de novo no corredor do supermercado.

**Justificativa:** Sem o perfil, o semáforo não tem como ser pessoal. É o dado que diferencia o NutriScan de um leitor genérico de rótulo. Atende a Ana, que consulta para si mesma, e o Roberto, que cadastra as restrições da filha.

### F02 Leitura de código de barras e QR Code

**Descrição:** A câmera do celular lê o código de barras ou o QR Code do produto. Ao abrir o aplicativo, a câmera já está disponível, sem botão extra para iniciar o scanner.

**Necessidade atendida:** Identificar o produto em segundos, com uma mão só, sem digitar nome ou código.

**Justificativa:** É a entrada principal da proposta de valor. No supermercado a pessoa está com pressa, com a outra mão ocupada pelo carrinho ou pela criança. A leitura substitui a interpretação manual do rótulo.

### F03 Consulta de informações do produto

**Descrição:** Depois da leitura, o aplicativo busca na base local os dados do produto, principalmente ingredientes e alergênicos associados ao código identificado.

**Necessidade atendida:** Conhecer a composição do alimento sem precisar decifrar o rótulo físico, em letra pequena e com nomes técnicos.

**Justificativa:** Sem esses dados não há análise. A consulta precisa acontecer no aparelho, porque a conexão no supermercado é instável ou inexistente.

### F04 Identificação de alergênicos

**Descrição:** O aplicativo cruza os alergênicos do produto com as restrições cadastradas no perfil e identifica o que representa risco para aquele usuário.

**Necessidade atendida:** Saber se o produto contém algo que a pessoa não pode consumir, inclusive quando o ingrediente aparece com outro nome, como soro de leite ou caseína.

**Justificativa:** Esse cruzamento é o objetivo central do NutriScan. Resolve o problema descrito na pesquisa: o consumidor comum não consegue reconhecer todos os nomes de alergênicos no rótulo.

### F05 Semáforo de segurança

**Descrição:** Mostra um indicador visual em verde, amarelo ou vermelho, com o nome do produto em letra grande. Verde indica que o produto é seguro para o perfil. Amarelo pede atenção, por exemplo quando há traços ou o produto não está na base. Vermelho indica que contém alergênico da restrição do usuário. Na dúvida, o resultado nunca é verde.

**Necessidade atendida:** Entender a resposta em um ou dois segundos, sem ler texto técnico no corredor.

**Justificativa:** O semáforo é obrigatório no estudo de caso e é o principal recurso visual do aplicativo. Atende o baixo nível de atenção do uso no supermercado: a cor informa antes da palavra. É também o que mais diferencia o NutriScan do Yuka e do Open Food Facts, que mostram informação nutricional geral, e se aproxima do Spoonful, com foco em restrição pessoal.

### F06 Detalhamento dos alergênicos encontrados

**Descrição:** Depois do semáforo, o usuário pode ver quais alergênicos ou ingredientes motivaram a classificação.

**Necessidade atendida:** Entender o motivo do verde, do amarelo ou do vermelho, e não só o veredito.

**Justificativa:** Aumenta a confiança no resultado. Para Ana, ajuda a reconhecer nomes que escondem glúten. Para Roberto, explica por que um chocolate foi barrado sem exigir que ele seja especialista em rótulo.

### F07 Histórico de produtos escaneados

**Descrição:** Lista os produtos já analisados, com o resultado obtido. O histórico pode ser anônimo e não é usado para marketing.

**Necessidade atendida:** Consultar de novo um produto conhecido sem repetir a leitura, principalmente em compras de rotina.

**Justificativa:** O estudo de caso prevê o histórico. Melhora o uso recorrente, desde que não atrapalhe o fluxo principal: depois do resultado, o retorno à câmera continua imediato.

### F08 Funcionamento offline

**Descrição:** A leitura, a consulta à base de alergênicos e o semáforo funcionam sem internet. A base vai embutida no aplicativo.

**Necessidade atendida:** Usar o NutriScan no supermercado mesmo sem rede ou com franquia de dados limitada.

**Justificativa:** O funcionamento offline não é um extra: é condição do estudo de caso. Se a consulta depender de internet, o aplicativo falha exatamente na hora em que Ana e Roberto precisam dele.




















## 2.4 CRUD

### Perfil de restrições alimentares

**C — Criar:**
O usuário configura suas restrições alimentares pela primeira vez.

**R — Consultar:**
O aplicativo consulta as restrições configuradas para comparar com os alergênicos encontrados nos produtos.

**U — Atualizar:**
O usuário pode alterar suas restrições alimentares quando necessário.

**D — Excluir:**
Não está definida no estudo de caso uma operação específica para exclusão do perfil ou de suas restrições.

### Histórico de produtos escaneados

**C — Criar:**
Cada produto analisado pode ser registrado no histórico.

**R — Consultar:**
O usuário pode consultar os produtos anteriormente escaneados e seus respectivos resultados.

**U — Atualizar:**
Não é necessário, pois o resultado da análise é gerado pelo sistema e não precisa ser alterado pelo usuário.

**D — Excluir:**
Não está definido no estudo de caso que o usuário poderá excluir registros do histórico.

### Base de dados de alergênicos

**C — Criar:**
Não se aplica, pois o usuário não cadastra novos alergênicos na base incorporada ao aplicativo.

**R — Consultar:**
O aplicativo consulta a base de dados para realizar a análise dos produtos.

**U — Atualizar:**
Não está definida uma funcionalidade para que o usuário atualize a base de alergênicos.

**D — Excluir:**
Não se aplica, pois o usuário não deve excluir informações da base de alergênicos.

### Resumo do CRUD

* **Perfil de restrições alimentares:** Criar, Consultar e Atualizar.
* **Histórico de produtos escaneados:** Criar e Consultar.
* **Base de dados de alergênicos:** Consultar.

---

## 2.5 Priorização das Funcionalidades

### Funcionalidades Essenciais

#### F01 — Perfil de restrições alimentares

É essencial porque o aplicativo precisa conhecer as restrições do usuário para realizar uma análise personalizada dos produtos.

#### F02 — Leitura de código de barras e QR Code

É essencial porque representa a principal forma de entrada de informações no aplicativo e permite identificar o produto de maneira rápida.

#### F03 — Consulta de informações do produto

É essencial porque o aplicativo precisa obter as informações necessárias sobre o produto para realizar a análise.

#### F04 — Identificação de alergênicos

É essencial porque corresponde diretamente ao principal problema que o NutriScan busca solucionar: identificar possíveis alergênicos relacionados às restrições do usuário.

#### F05 — Semáforo de segurança

É essencial porque é o principal recurso visual do aplicativo e está definido como obrigatório no estudo de caso.

#### F08 — Funcionamento offline

É essencial porque o estudo de caso determina que a leitura e a análise dos produtos devem funcionar sem conexão com a internet.

### Funcionalidades Importantes

#### F06 — Detalhamento dos alergênicos encontrados

É importante porque permite que o usuário compreenda por que determinado produto recebeu aquela classificação de segurança.

#### F07 — Histórico de produtos escaneados

É importante porque permite consultar produtos que já foram analisados, facilitando o uso recorrente do aplicativo.

### Funcionalidades Secundárias

Não foram definidas funcionalidades secundárias nesta versão do projeto.

As oito funcionalidades definidas estão diretamente relacionadas ao fluxo principal ou às necessidades identificadas no estudo de caso, pesquisa e personas. Por isso, todas foram classificadas como **Essenciais** ou **Importantes**.

### Resumo da priorização

* **Essenciais:** F01, F02, F03, F04, F05 e F08.
* **Importantes:** F06 e F07.
* **Secundárias:** Nenhuma.
