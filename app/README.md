# NutriScan — aplicativo

App Flutter do NutriScan: leitura de código de barras e semáforo de alergênicos
para pessoas com alergias e intolerâncias alimentares. A documentação do projeto
(pesquisa, personas, requisitos, protótipos e justificativas de design) está em
[`../docs`](../docs).

## Como rodar

### Pré-requisitos

- Flutter 3.47 ou superior (`flutter --version`)
- Para Android: Android Studio com um emulador ou um aparelho com depuração USB
- Para iOS: Xcode e um simulador (apenas em macOS)
- Para web: Google Chrome

Confira o ambiente com `flutter doctor`.

### Passos

```bash
cd app
flutter pub get
flutter devices          # lista os aparelhos disponíveis
flutter run              # roda no aparelho padrão
flutter run -d chrome    # roda no navegador
```

A tela inicial abre a câmera traseira. Na primeira execução o sistema pede
permissão de câmera; se ela for negada, a tela mostra o fundo do protótipo no
lugar da pré-visualização. No navegador a câmera só funciona em `localhost` ou HTTPS.

### Verificações

```bash
flutter analyze          # lint e erros estáticos
flutter test             # testes de widget
flutter build apk --debug
```

## Arquitetura

O projeto segue uma organização **feature-based com camadas** (apresentação,
domínio e dados). A ideia é que cada funcionalidade do app seja autocontida e
que a regra de negócio (o semáforo) não dependa de Flutter, banco ou câmera,
como descrito na seção 9 de [`justificativas.md`](../docs/justificativas.md).

```
lib/
├── main.dart                 # ponto de entrada
├── app.dart                  # MaterialApp: tema e rotas
├── core/                     # infraestrutura usada por todas as features
│   ├── theme/                # cores e tipografia do Figma
│   ├── routing/              # tabela de rotas
│   ├── widgets/              # widgets genéricos (ex.: borda tracejada)
│   ├── config/ constants/ di/ error/ extensions/ network/ utils/
├── shared/                   # modelos, serviços e repositórios usados por mais de uma feature
└── features/                 # uma pasta por funcionalidade
    ├── home/                 # câmera e leitura (tela inicial)
    ├── profile/              # restrições alimentares da pessoa
    └── auth/
```

### Camadas dentro de uma feature

```
features/home/
├── presentation/             # o que a pessoa vê
│   ├── pages/                # uma tela completa (HomePage)
│   ├── widgets/              # pedaços da tela (moldura de leitura, barra inferior…)
│   ├── controllers/          # estado da tela e reação a eventos
│   └── state/                # classes que descrevem o estado da tela
├── domain/                   # regra de negócio em Dart puro, sem Flutter
│   ├── entities/             # Produto, Perfil, Resultado…
│   ├── usecases/             # "analisar produto", "registrar leitura"…
│   └── repositories/         # contratos (interfaces) que o domínio precisa
└── data/                     # implementação dos contratos
    ├── models/               # conversão de/para JSON e banco
    ├── datasources/          # local (SQLite) e remote (quando houver)
    └── repositories/         # implementações das interfaces do domínio
```

A dependência só aponta para dentro: `presentation` conhece `domain`,
`data` implementa `domain`, e `domain` não conhece ninguém. Assim o motor do
semáforo pode ser testado sem emulador e a câmera ou o banco podem ser
trocados sem mexer na regra.

## Estrutura de testes

`test/` espelha `lib/`: cada feature tem `data`, `domain` e `presentation`.
Testes de domínio não precisam de Flutter; testes de tela usam `flutter_test`
com `testWidgets`. Hoje existe o teste da Home em
`test/features/home/presentation/home_page_test.dart`.
