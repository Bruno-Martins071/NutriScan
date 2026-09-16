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
