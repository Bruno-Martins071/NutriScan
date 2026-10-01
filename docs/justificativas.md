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

## 6. Componentes

Os componentes seguem o Material Design 3, padrão do Android. Isso deixa o aplicativo familiar para quem já usa celular Android e tem implementação pronta no Jetpack Compose.

| Componente | Onde | Função e motivo |
|---|---|---|
| **Moldura de leitura com cantos e linha de varredura** | Home | Mostra onde apontar. Na leitura, os cantos assumem a cor do semáforo. É o elemento de assinatura visual. |
| **Chip "Offline · base local"** | Home, Resultado | Confirma que tudo funciona sem rede (F08) e tira a dúvida sobre sinal no corredor. |
| **Chip de perfil (avatar + restrições)** | Home, Resultado | Mostra o perfil ativo e abre o Perfil com um toque. |
| **Barra inferior em vidro com dois atalhos de 64 px** | Home | Histórico e Perfil, com ícone, rótulo e subtítulo. Grandes o bastante para o polegar. |
| **Botão tracejado "Digitar ingredientes"** | Home | Rota de exceção (RF10). O tracejado indica ação secundária e não compete com a câmera. |
| **Chips "Verificado para"** | Resultado | Mostram as restrições consideradas na análise. |
| **Cartão "Por que é..."** | Resultado | Uma linha por restrição, com ícone e texto (RF13). |
| **Botão "Ler outro produto"** | Resultado | Ação principal no rodapé, ao alcance do polegar. |
| **Lista com etiqueta de status, deslize e "Desfazer"** | Histórico | Etiqueta com texto (RNF03) e exclusão reversível (RF16). |
| **Chips selecionáveis com marca de seleção** | Perfil | Marcar várias restrições só com toques, sem digitar (RF01). |
| **Campo com sugestões e botão Adicionar** | Perfil | Restrição personalizada. A sugestão reduz digitação (tartrazina aparece como "Corante amarelo"). |
| **Chave "Avisar sobre traços"** | Perfil | Deixa explícito que "pode conter" vira amarelo. |
| **Faixa com cadeado "Fica só neste aparelho"** | Perfil | Informa a finalidade e o local de armazenamento dos dados (RNF05). |
| **Campo de texto longo com contador e detecção ao vivo** | Digitar ingredientes | Mostra os alergênicos enquanto a pessoa digita e evita lista incompleta. |

## 7. Acessibilidade

O estudo de caso não traz requisitos de acessibilidade específicos, apenas pede nome do produto em fonte grande e sinais visuais claros. Por isso o grupo adotou como referência a WCAG 2.1 nível AA e as recomendações de acessibilidade do Android, além dos requisitos RNF03 e RNF04.

| Critério | Como o protótipo atende |
|---|---|
| **Informação que não depende só de cor (WCAG 1.4.1, RNF03)** | Ícone e palavra em todos os estados do semáforo, etiqueta de texto no histórico e marca de seleção nos chips do perfil. |
| **Contraste mínimo de 4,5:1 para texto (WCAG 1.4.3)** | Cores da câmera entre 5,4:1 e 17,3:1. Resultado amarelo com 10,6:1 e vermelho com 5,3:1. No verde, o texto branco tem 3,4:1, acima do mínimo de 3:1 para texto grande, como o nome do produto; os textos pequenos dessa tela serão escurecidos no desenvolvimento. |
| **Fonte grande e texto ampliável** | Nome do produto em 32 px. Nenhum texto abaixo de 12 px. No app, tamanhos em sp para seguir a configuração de fonte do sistema. |
| **Alvos de toque** | No mínimo 44 px no protótipo e 64 px na barra inferior. No desenvolvimento, 48 dp, que é o mínimo recomendado pelo Android. |
| **Feedback tátil (RNF04)** | Vibração curta quando o código é lido. No desenvolvimento, um padrão de vibração diferente para o vermelho, para o aviso chegar mesmo sem olhar a tela. |
| **Movimento reduzido** | Com "remover animações" ativo no Android, a linha de varredura fica parada. |
| **Leitor de tela (TalkBack)** | O resultado será anunciado como uma frase completa, por exemplo: "Contém alergênico. Chocolate ao Leite. Lactose: contém soro de leite". |
| **Uso com uma mão** | Ações frequentes na metade de baixo da tela e exclusão por deslize. |
| **Linguagem simples** | "Pode conter" no lugar de "contaminação cruzada" no veredito. O termo técnico só aparece na explicação. |

## 8. Decisões ligadas ao contexto de uso

| Condição (estudo de caso e personas) | Decisão no protótipo |
|---|---|
| **Uma mão ocupada com carrinho, cesta ou criança** | Câmera sem botão de iniciar, ações no rodapé, alvos grandes, nada para digitar no fluxo principal. |
| **Pressa e atenção de um ou dois segundos** | Tela inteira na cor do semáforo, nome em 32 px, uma instrução só na Home. |
| **Várias leituras seguidas na mesma compra** | "Ler outro produto" volta direto para a câmera, sem menu no caminho. |
| **Corredor barulhento** | Confirmação visual e por vibração. Nenhum aviso depende de som. |
| **Luz artificial fraca e embalagens que refletem** | Fundo escuro na câmera, moldura clara, cores saturadas. |
| **Conexão instável e franquia de dados limitada** | Base embutida, chip "Offline · base local", análise manual feita no aparelho. |
| **Um "seguro" errado causa dano real** | Na dúvida, nunca verde: traços e produto fora da base viram amarelo, e a digitação manual lembra de conferir a lista inteira. |
| **Dado de saúde é sensível** | Sem cadastro nem login, perfil e histórico só no aparelho, aviso explícito na tela de Perfil. |
| **Quem compra para outra pessoa (Roberto)** | "Para quem é este perfil?" com nome opcional e "Verificado para" em cada resultado. |

## 9. Arquitetura do sistema

O NutriScan será um **aplicativo Android nativo, escrito em Kotlin com Jetpack Compose**, sem servidor no fluxo principal: tudo que a consulta precisa está no aparelho. A escolha segue o requisito de rodar em Android de entrada (RNF13) e as bibliotecas já citadas no RF05 (CameraX e ML Kit). O código é organizado nas camadas recomendadas pelo Android, com o padrão MVVM na interface.

| Camada | O que contém | Responsabilidade |
|---|---|---|
| **Apresentação (UI)** | Telas em Compose e um ViewModel por tela (Scanner, Resultado, Histórico, Perfil, Digitar ingredientes). | Desenhar a tela, guardar o estado dela e navegar. Não conhece banco nem regra de alergênico. |
| **Domínio** | Casos de uso: identificar produto, analisar produto, registrar leitura, salvar perfil. Motor do semáforo. | Regras do negócio em Kotlin puro, testáveis sem celular. Aqui mora a regra "na dúvida, nunca verde". |
| **Dados** | Repositórios de produto, histórico e perfil. | Ler e gravar no armazenamento local, escondendo da camada de cima onde o dado está. |
| **Serviços do aparelho** | CameraX, ML Kit, vibração. | Acesso ao hardware, isolado atrás de interfaces. |

### Componentes e função no projeto

| Componente | Função | Atende |
|---|---|---|
| **Jetpack Compose + Material 3** | Monta as telas com as cores, a tipografia e os componentes do protótipo. | RF12, RNF02, RNF08 |
| **Navigation Compose** | Navegação entre as telas. No Resultado, o voltar do Android retorna direto à câmera. | RNF01 |
| **ViewModel + StateFlow** | Guarda o estado de cada tela e sobrevive à rotação e a mudanças de tamanho de tela. | RNF08 |
| **CameraX** | Pré-visualização em tela cheia, foco automático e controle da lanterna. | RF04, RNF14 |
| **ML Kit Barcode Scanning (versão embutida)** | Lê código de barras e QR Code no próprio aparelho. A versão embutida já traz o modelo no app e não depende de download pelo Google Play Services. | RF05, RF06, F08 |
| **Base de produtos (SQLite via Room, pré-carregada)** | Produtos por código: nome, marca, ingredientes, alergênicos e traços. Fonte candidata: recorte de produtos brasileiros do Open Food Facts (licença ODbL), já analisado no benchmark. | RF07, RF08, RNF10 |
| **Dicionário de sinônimos** | Liga o nome do rótulo ao alergênico: soro de leite e leite em pó levam a lactose e leite; caseína e lactoalbumina levam à proteína do leite; farinha de trigo, malte e cevada levam a glúten. | F04, RF09 |
| **Motor de análise** | Cruza ingredientes e traços com o perfil e devolve verde, amarelo ou vermelho com os motivos. Sem dados ou com traços, nunca devolve verde. | RF09, RF11, RNF12, RNF16 |
| **Room: tabela de histórico** | Guarda produto, resultado e data de cada leitura e permite apagar. | RF14, RF15, RF16 |
| **DataStore** | Guarda o perfil de restrições no armazenamento privado do app, sem conta e sem envio. | RF02, RNF06, RNF09 |
| **Vibração (haptics)** | Confirma a leitura e diferencia o alerta vermelho. | RNF04 |

### Fluxo de uma leitura

1. A CameraX entrega os quadros da câmera ao ML Kit.
2. O ML Kit reconhece o código e o app vibra.
3. O caso de uso "identificar produto" busca o código na base local.
4. Se encontrar, o motor de análise cruza os ingredientes com o perfil. Se não encontrar, o resultado é "Não está na base", em amarelo.
5. A leitura é gravada no histórico.
6. A tela mostra o semáforo. A busca em banco local indexado leva milissegundos, o que cabe com folga nos 2 segundos do RNF07.

### Restrições técnicas

- **Tamanho até 15 MB (RNF15):** publicação em Android App Bundle (a loja entrega só o código da arquitetura do aparelho), minificação com R8, fonte só com os pesos usados e base compactada. O ML Kit embutido soma alguns MB. Se a base completa não couber, entram os produtos mais vendidos e o restante é atendido por "Digitar ingredientes".
- **Privacidade (RNF05, RNF06):** nenhum dado do usuário sai do aparelho. A internet só é usada para atualizar a base de produtos (RNF11), baixando um pacote de dados novo, sem enviar nada sobre o usuário. Sem conexão, tudo continua funcionando com a base local.
- **Versão do Android:** o estudo de caso não define. A proposta é Android 7.0 (API 24) ou superior, que cobre a maior parte dos aparelhos em uso, a confirmar pela equipe.
