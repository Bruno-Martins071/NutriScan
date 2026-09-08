1.0. Objetivo 

O NutriScan tem como conceito principal facilitar o acompanhamento nutricional relacionado às restrições alimentares. O problema identificado está na dificuldade de realizar manualmente o controle dos alimentos consumidos e verificar se determinado produto é adequado às restrições alimentares de cada usuário. Esse processo pode ser trabalhoso, demorado e pouco prático, principalmente durante a compra de produtos industrializados.  

Para solucionar esse problema, o NutriScan propõe o desenvolvimento de um aplicativo com scanner de código de barras/ leitura de rótulos, capaz de consultar uma base de dados com informações nutricionais e sobre alergênicos. Com base no perfil e nas restrições alimentares cadastradas pelo usuário, o sistema analisa o produto e apresenta um semáforo de segurança, indicando se o alimento é seguro, se exige atenção ou se contém algum componente que deve ser evitado.  

A solução é destinada principalmente a pessoas com alergias e intolerâncias alimentares, pacientes com doença celíaca e pais de crianças alérgicas, podendo também auxiliar nutricionistas e médicos especialistas. O aplicativo será utilizado principalmente em supermercados, onde o usuário precisa tomar decisões rápidas sobre quais produtos pode ou não consumir.  

O principal objetivo do projeto é proporcionar uma forma rápida, prática e confiável de identificar possíveis riscos alimentares, reduzindo a necessidade de interpretar manualmente todas as informações presentes nos rótulos. 


2.1. Problema 

Explique: 

Qual problema o aplicativo pretende ajudar a solucionar? O NutriScan busca resolver a dificuldade de identificar rapidamente alergênicos em produtos industrializados. 

Por que esse problema é relevante? É relevante porque pessoas com alergias e intolerâncias, precisam tomar decisões seguras durante as compras. 

Qual é a principal necessidade que a solução deverá atender? A solução deverá permitir a identificação rápida de produtos por meio do código de barras e de um semáforo de segurança, indicando se o alimento é seguro ou contém algum alergênico para o usuário. 


2.2. Público e usuários 

Analise os públicos indicados no estudo de caso. Para cada público relevante, identifique: 

Quem é? Pessoas que possuem alergias ou intolerâncias alimentares e precisam ter cuidado com os produtos que compram e consomem.

Qual relação possui com o aplicativo? São os principais usuários do aplicativo, utilizando-o para verificar se um produto possui ingredientes que podem causar problemas relacionados às suas restrições.

Quais necessidades possui? Precisam identificar rapidamente alergênicos nos produtos, principalmente quando as informações dos rótulos são difíceis de interpretar. O aplicativo também pode proporcionar mais autonomia durante as compras.

Em que situação poderá utilizar a solução? Principalmente durante compras em supermercados, no momento de escolher um produto.

2.3. Contexto de uso    

Identifique os diferentes contextos nos quais o aplicativo poderá ser utilizado. Considere as informações fornecidas no estudo de caso, como: 

Ambiente 

Momento de utilização 

Condições do usuário 

Dispositivo 

Conectividade 

Iluminação 

Nível de atenção 

Situação de urgência 

Outras condições específicas 

 
Explique como esses contextos podem influenciar o desenvolvimento do aplicativo. 
 
Resposta: O NutriScan é utilizado de pé, com pressa, em frente à prateleira do supermercado. Esse conjunto de condições é o que define as principais decisões do projeto. 
 
Ambiente - O uso ocorre em corredores de supermercado, com circulação de pessoas, carrinho ocupando espaço e ruído de fundo. Isso exige que o aplicativo funcione com uma mão só, mantendo os controles essenciais ao alcance do polegar. Como o retorno sonoro é pouco eficaz em ambiente ruidoso, a confirmação da leitura deve ser visual e tátil, por vibração. 
 
Momento de utilização - A consulta acontece nos segundos que antecedem a decisão de colocar o produto no carrinho e frequentemente se repete em vários produtos seguidos. O fluxo precisa ser: após a exibição do resultado, o retorno à câmera deve ser imediato, sem passagem por menus. 
 
Condições do usuário - A pessoa está com pressa e quase sempre com as mãos ocupadas, segurando o carrinho, a cesta, a lista de compras ou a criança. Por isso o aplicativo não pode pedir que ela digite nada nem preencha campos durante o uso principal, e precisa conseguir ler o código mesmo com a mão ocupada ou com o celular um pouco torto. 
 
Dispositivo e Conectividade - O aplicativo deve rodar em smartphones básicos, com câmera de 5 MP, pouca memória e pouco armazenamento livre, em locais onde a conexão é instável ou inexistente e onde parte do público possui franquia de dados limitada. Isso impõe o limite de 15 MB para o pacote, o uso de bibliotecas otimizadas, principalmente, o funcionamento offline como requisito e não como recurso complementar e a consulta não pode depender de rede. 
 
Iluminação - O supermercado tem luz artificial fraca, e as embalagens plásticas e metalizadas refletem essa luz. Além disso, o próprio corpo da pessoa costuma fazer sombra sobre o produto na hora de apontar a câmera. Por isso o aplicativo precisa poder acender a lanterna do celular, e as cores do semáforo precisam ser fortes o bastante para continuar visíveis nessa iluminação e em telas mais simples, de brilho fraco. 
 
Nível de atenção - A pessoa não está olhando só para o celular. Ela divide a atenção entre o aplicativo, o carrinho, a lista de compras e o que acontece em volta, então dá apenas uma olhada rápida na tela, de um ou dois segundos. O resultado precisa ser entendido sem que ela precise ler nada, o que é justamente o papel do semáforo: a cor informa antes da palavra. É também o que explica a exigência de nome do produto em letra grande, resposta em menos de dois segundos e o uso todo em até três toques. 
 
Situação de urgência - Não é uma emergência de saúde, mas é uma decisão que não dá para desfazer depois. Se o aplicativo disser que é seguro e não for, a pessoa passa mal ou, no caso de quem tem doença celíaca, sofre um dano real. Ou seja, os dois erros possíveis não têm o mesmo peso. Sempre que houver dúvida, como um produto que não está na base ou um rótulo que indica possibilidade de traços, o aplicativo deve mostrar amarelo e nunca verde. 

2.4. Objetivo e proposta de valor

Explique, com suas próprias palavras: O que o aplicativo pretende oferecer e qual benefício deverá proporcionar ao usuário? 
 
Resposta: O NutriScan quer responder uma pergunta simples que hoje é difícil de responder: este produto é seguro para mim? A pessoa aponta a câmera para o código de barras e recebe a resposta em cores. Verde significa que pode levar, amarelo pede atenção e vermelho indica que o produto contém algo que ela não pode consumir. 
 
A informação já existe no rótulo, mas está em letra pequena e escrita de um jeito que a maioria das pessoas não entende. Muitos ingredientes que contêm leite, soja ou glúten aparecem com outros nomes, e reconhecer isso exige um conhecimento que o consumidor comum não tem. O aplicativo faz essa leitura no lugar dele. 
 
O principal benefício é dar segurança sem exigir esforço. Hoje a pessoa precisa escolher entre parar e analisar cada embalagem ou comprar sem ter certeza. O aplicativo acaba com essa escolha, porque entrega em poucos segundos algo que antes levaria minutos e ainda podia dar errado. 

2.5 - Personalidade, identidade e experiência 

Analise: 

Palavras conceituais 

Personalidade da identidade 

Tom da interface 

Tom da experiência do usuário 

Forma como o aplicativo deseja ser lembrado 

Explique como essas características deverão influenciar a solução. Não é necessário desenvolver a identidade visual nesta atividade. 

Resposta: As palavras conceituais do NutriScan estão relacionadas a alergênicos, segurança alimentar, rotulagem, lactose, glúten, código de barras e ANVISA. A identidade deve transmitir uma personalidade prática, tecnológica e confiável. 

Essas características devem influenciar a solução por meio de uma interface simples, rápida e direta, facilitando o uso no ambiente do supermercado. A experiência do usuário deve priorizar agilidade, com a câmera disponível imediatamente e o resultado apresentado de forma visual pelo semáforo de segurança.  

O aplicativo deseja ser lembrado como um “guardião invisível” da saúde do usuário, auxiliando na identificação rápida de produtos adequados às suas restrições alimentares. Dessa forma, a solução deve transmitir segurança, confiança e praticidade em todas as interações.

2.6 - Funcionalidades e características já definidas 

Identifique as principais funcionalidades e características que já foram estabelecidas no estudo de caso. 

Para cada uma, explique brevemente qual necessidade ela atende. 

Funcionalidade: Scanner de código de barras / rótulos  

Necessidade atendida: Permite a identificação rapidamente dos produtos no supermercado sem que o usuário digite as informações manualmente. 

Funcionalidade: Exibição do “Semáforo Nutricional” (Verde, Amarelo e Vermelho) 

Necessidade atendida: Facilita a compreensão imediata sobre a segurança do produto para a pessoas com alergias ou restrições alimentares. 

Funcionalidade: Cadastro do perfil de restrições do usuário (glúten, lactose, amendoim, soja, etc.). 

Necessidade atendida: Personaliza a análise dos produtos de acordo com as necessidades específicas de cada usuário. 

2.7 - Restrições e condições 

Identifique as restrições apresentadas no estudo de caso que deverão ser respeitadas durante o projeto. Podem estar relacionadas a: 

Quantidade de telas: o protótipo deve possuir no máximo 4 telas principais. 

Número de interações: a funcionalidade principal deve ocorrer em até 3 interações, com a câmera já aberta ao iniciar o aplicativo. 

Dispositivos: o aplicativo deve funcionar em smartphones básicos com câmera de pelo menos 5 MP. 

Versão do sistema operacional: não foi especificada no estudo de caso, portanto essa restrição deverá ser definida pela equipe durante o desenvolvimento. 

Tamanho do aplicativo: deve ser leve, com menos de 15 MB. 

Privacidade e armazenamento: o perfil de restrições do usuário deve ser armazenado apenas localmente, e o histórico pode ser anônimo, sem utilização para marketing. 

Conectividade: o scanner deve funcionar offline, com a base de dados de alergênicos embutida no aplicativo. 

Navegação: deve ser simples, rápida e direta, priorizando o uso imediato da câmera. 

Acessibilidade: não há requisitos específicos de acessibilidade descritos no estudo de caso. Porém, a interface deve apresentar informações de forma clara e rápida, com nome do produto em fonte grande e uso de sinais visuais para facilitar a compreensão. 

Ambiente de utilização: o aplicativo será utilizado principalmente em supermercados, com iluminação artificial, sendo necessário garantir uma visualização rápida e clara das informações. 

Condições específicas: o resultado deve utilizar obrigatoriamente o semáforo de segurança (verde, amarelo e vermelho), com o nome do produto em fonte grande e resultado apresentado rapidamente. 

 

2.8 - Pontos de atenção 

Ao final da análise, o grupo deverá responder: 

Quais são os 3 aspectos do estudo de caso que consideramos mais importantes para o sucesso do aplicativo? 

 1. Ser rápido e fácil de usar 

O usuário vai estar no supermercado, provavelmente com pressa e com outras coisas para fazer. Então, não pode ficar procurando botão ou preenchendo informações. A câmera já deve abrir e, ao apontar para o código de barras, o resultado deve aparecer rapidamente. Quanto mais simples for o uso, maior a chance de a pessoa realmente usar o app no dia a dia. 

 2. Mostrar o resultado de um jeito claro 

A pessoa precisa saber quase na hora se pode ou não comprar aquele produto. Por isso, o semáforo é muito importante: verde significa seguro, amarelo significa atenção e vermelho significa que tem alergênico. É uma forma simples de entender o resultado sem precisar ficar lendo um monte de informações no rótulo. 

 3. Funcionar sem internet e proteger os dados 

No supermercado, a internet pode estar ruim ou nem funcionar. Se o aplicativo depender de internet, pode deixar de cumprir sua principal função justamente quando o usuário precisar. Por isso, o scanner precisa funcionar offline. 

Além disso, informações sobre alergias e restrições são pessoais. O aplicativo deve guardar essas informações somente no celular do usuário, sem usar esses dados para publicidade ou marketing. 