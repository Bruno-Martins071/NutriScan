## 2. Cores: paleta e contraste

A paleta tem dois papéis. Os neutros escuros e claros formam um fundo que não disputa atenção. As três cores do semáforo carregam a informação principal. O verde também é a cor da marca, alinhado à personalidade prática, tecnológica e confiável definida no estudo de caso (o "guardião invisível").

| Cor | Papel | Contraste |
|---|---|---|
| **#0B1416** | Superfície da câmera e texto escuro (amarelo e telas claras) | Base de cálculo |
| **#F4F7F5** | Texto e ícones sobre a câmera e fundo das telas claras (Histórico, Perfil) | 17,3:1 com #0B1416 |
| **#A7B3B0** | Texto secundário sobre a câmera | 8,6:1 sobre #0B1416 |
| **#122022** | Vidro dos chips e da barra inferior | Superfície |
| **#2ECC85** | Verde do semáforo sobre a câmera e cor da marca | 9,0:1 sobre #0B1416 |
| **#F5B93D** | Amarelo do semáforo (atenção) e fundo do resultado amarelo, com texto escuro | 10,6:1 com #0B1416 |
| **#F0525A** | Vermelho do semáforo (contém alergênico) | 5,4:1 sobre #0B1416 |
| **#1E9E63** | Fundo do resultado verde, texto branco | 3,4:1 com branco (texto grande) |
| **#C8323A** | Fundo do resultado vermelho, texto branco | 5,3:1 com branco |

- **A cor ocupa a tela inteira no resultado.** A pessoa olha para o celular por um ou dois segundos. Uma tela toda vermelha é percebida até na visão periférica, antes de qualquer leitura. É o que o estudo de caso chama de "a cor informa antes da palavra".
- **Fundo escuro na câmera e cores saturadas.** O supermercado tem luz artificial fraca e embalagens que refletem. Controles escuros não competem com o vídeo, e as cores fortes continuam distinguíveis em telas simples de brilho baixo.
- **Cada fundo recebe o texto de maior contraste.** O amarelo leva texto escuro (10,6:1) e o vermelho leva texto branco (5,3:1).
- **A cor nunca aparece sozinha.** Todo estado do semáforo tem ícone (visto, exclamação, X) e palavra (SEGURO PARA VOCÊ, ATENÇÃO: PODE CONTER, CONTÉM ALERGÊNICO). Quem tem daltonismo vermelho e verde, o tipo mais comum, entende o resultado pelo ícone e pelo texto (RNF03).

## 3. Tipografia: hierarquia e legibilidade

A fonte escolhida é a **Inter**, uma sans-serif desenhada para telas. Ela tem altura-x grande, letras abertas e números bem diferenciados, o que ajuda na leitura rápida e em telas de baixa resolução. A licença é aberta (SIL Open Font License), então pode ser embutida no aplicativo sem custo, o que também evita depender de download de fonte (F08). Só os pesos usados entram no pacote, para respeitar o limite de 15 MB (RNF15).

| Nível | Peso | Tamanho / altura de linha | Onde aparece |
|---|---|---|---|
| **Nome do produto** | Bold | 32 / 38 | Resultado. É o maior texto do app, como pede o estudo de caso (RF12). |
| **Título de instrução** | SemiBold | 17 / 24 | "Aponte para o código de barras ou QR Code" e títulos de tela. |
| **Texto de apoio** | Regular | 15 / 22 | Explicações curtas e motivos do resultado. |
| **Chips e botões** | Medium | 14 / 20 | Restrições, etiquetas de status e ações. |
| **Rótulos da barra** | Medium | 12 / 16 | Subtítulos dos atalhos. Menor tamanho usado no app. |

- **O veredito vem em caixa alta, curto e acima do nome.** Ele funciona como um rótulo e é lido de relance; o nome do produto confirma que a leitura foi do item certo.
- **Nenhum texto abaixo de 12 px.** No desenvolvimento os tamanhos serão definidos em sp, para acompanhar o tamanho de fonte escolhido pela pessoa no Android.

## 4. Organização das informações

A regra geral é mostrar primeiro o que decide e depois o que explica. Cada tela tem um único trabalho.

### Resultado: leitura em camadas

1. Cor da tela inteira: basta para decidir.
2. Ícone e veredito em caixa alta: confirmam a cor sem depender dela.
3. Nome do produto em 32 px, com marca e peso: confirma que foi lido o produto certo.
4. Cartão "Por que é...": uma linha por restrição do perfil, com o motivo.
5. "Ver ingredientes" e "Ler outro produto": aprofundar ou seguir as compras.

Roberto para no primeiro nível: vê vermelho, devolve o chocolate e aponta para o próximo. Ana, que precisa confiar no "sem glúten" da embalagem, desce até o cartão ou abre a lista de ingredientes. A mesma tela atende aos dois sem obrigar ninguém a ler.

### Demais telas

- **Home:** a câmera ocupa a tela. O topo mostra o estado (offline e perfil ativo), o centro tem a moldura e uma única instrução, e a base concentra as ações secundárias, na área que o polegar alcança.
- **Histórico:** agrupado por dia, do mais recente para o mais antigo. O nome fica à esquerda, onde o olho começa, e o resultado fica à direita como etiqueta.
- **Perfil:** blocos na ordem em que a pessoa pensa: para quem é, do que precisa se proteger, como tratar traços e salvar. O botão salvar fica fixo embaixo com um resumo ("2 restrições + 1 personalizada").
- **Digitar ingredientes:** o que foi encontrado aparece enquanto a pessoa digita, para ela perceber na hora se esqueceu algum trecho do rótulo.

## 5. Navegação

A câmera é o centro do aplicativo. Todas as outras telas saem dela e voltam para ela. Por isso não foi usada uma barra de abas: Histórico e Perfil são atalhos, e a tela principal é a própria câmera.

| Fluxo | Caminho | Toques |
|---|---|---|
| **Principal (F02 a F05)** | Abrir o app, câmera já ativa, apontar, leitura automática, Resultado. | 0 até o resultado |
| **Seguir comprando** | Resultado, "Ler outro produto" (ou voltar do Android), câmera. | 1 |
| **Entender o resultado (F06)** | Resultado, "Ver ingredientes", lista de ingredientes. | 1 |
| **Produto fora da base (RF10)** | Home ou "Não está na base", Digitar ingredientes, Analisar, Resultado. | 2 + digitação |
| **Histórico (F07)** | Home, Histórico, deslizar para apagar, "Desfazer" se precisar. | 1 |
| **Perfil (F01)** | Primeiro uso: "Monte seu perfil". Depois: Home, Perfil (barra ou chip do topo). | 1 |

- **RNF01 pede o escaneamento em até três interações.** O protótipo faz em zero: a leitura começa sozinha, sem botão de iniciar (RF04).
- **O estudo de caso limita o protótipo a quatro telas principais.** Home, Resultado, Histórico e Perfil são as quatro. Ingredientes é um aprofundamento do Resultado e Digitar ingredientes é uma rota de exceção; nenhuma das duas faz parte do fluxo principal. "Monte seu perfil" é a versão de primeiro uso da tela de Perfil, necessária uma única vez, porque sem restrições o semáforo não tem como ser pessoal.
- **O perfil fica visível e a um toque de distância em todas as leituras.** O chip do topo mostra contra o que o produto foi verificado, o que evita que alguém que alterna perfis leia o resultado do perfil errado.
- **Cada tela é fácil de localizar.** Toda tela secundária tem título e botão de voltar no canto superior esquerdo, no padrão do Android, e o Histórico agrupa as leituras por dia para achar rápido um produto de uma compra anterior.
