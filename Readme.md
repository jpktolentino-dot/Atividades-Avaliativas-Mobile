# Calculadora Flutter

Uma calculadora mobile desenvolvida em Flutter/Dart. O projeto possui componentização e gerenciamento de estado em Flutter.

## Visão Geral

A aplicação oferece as quatro operações matemáticas básicas, suporte a números decimais, inversão de sinal e cálculo de porcentagem.

## Tecnologias

- [Flutter](https://flutter.dev/) (framework UI)
- [Dart](https://dart.dev/) (linguagem)

## Estrutura do Código

O projeto é composto por um único arquivo `main.dart`, organizado nos seguintes blocos:

```
main.dart
│
├── main()                     → Ponto de entrada da aplicação
├── calculadoraApp             → Widget raiz (StatelessWidget)
├── CalculadoraPage            → Página principal (StatefulWidget)
│   └── _CalculadoraPageState  → Lógica e estado da calculadora
│
├── DisplayCard                → Componente do visor
├── TipoBotao (enum)           → Define os tipos de botão
└── BotaoCalculadora           → Componente reutilizável de botão
```

## Componentização

### `DisplayCard`
Widget responsável exclusivamente por renderizar o valor atual na tela. Recebe o valor como `String` e o tamanho da fonte dinamicamente, variando conforme o comprimento do número exibido.

### `TipoBotao` (enum)
Define os três papéis que um botão pode assumir, centralizando a lógica visual:

| Tipo       | Descrição                          | Exemplo     |
|------------|------------------------------------|-------------|
| `numero`   | Dígitos de 0 a 9 e ponto decimal   | `1`, `5`, `.` |
| `funcao`   | Funções auxiliares                 | `AC`, `+/-`, `%` |
| `operador` | Operações matemáticas e igual      | `+`, `÷`, `=` |

### `BotaoCalculadora`
Componente reutilizável que representa qualquer botão da calculadora. Toda a aparência (cor, fonte) é derivada automaticamente do `TipoBotao` informado. Principais propriedades:

| Propriedade        | Tipo          | Descrição                                        |
|--------------------|---------------|--------------------------------------------------|
| `label`            | `String`      | Texto exibido no botão                           |
| `tipo`             | `TipoBotao`   | Define as cores do botão                         |
| `onPressed`        | `VoidCallback`| Função executada ao toque                        |
| `ativo`            | `bool`        | Destaca o botão quando o operador está selecionado|

Usa `AnimatedContainer` para uma transição de cor ao pressionar.

## Lógica de Estado

O estado da calculadora é mantido em `_CalculadoraPageState` através de cinco variáveis:

| Variável            | Tipo      | Descrição                                             |
|---------------------|-----------|-------------------------------------------------------|
| `_display`          | `String`  | Valor exibido na tela                                 |
| `_valorAnterior`    | `double`  | Primeiro operando da operação                         |
| `_operacao`         | `String?` | Operador selecionado (`+`, `-`, `×`, `÷`)             |
| `_aguardandoOperando` | `bool`  | Indica se o próximo dígito inicia um número novo      |
| `_temDecimal`       | `bool`    | Impede a inserção de dois pontos decimais             |

Toda atualização de estado usa `setState()`, garantindo que o Flutter redesenhe apenas os widgets afetados.

---

## Funcionalidades

- Operações básicas: adição, subtração, multiplicação e divisão
- Números decimais
- Inversão de sinal (`+/-`)
- Cálculo de porcentagem (`%`)
- Operações encadeadas (ex: `2 + 3 × 4`)
- Destaque visual no operador ativo
- Proteção contra divisão por zero (exibe `Erro`)
- Limite de 9 dígitos no display

---

## Layout

A tela é construída com `Column` e `Row`. O widget `Expanded` faz cada botão ocupar o espaço disponível igualmente. O botão `0` usa `flex: 2` para ocupar o dobro da largura dos demais.

```
[ AC ]  [ +/- ]  [  %  ]  [  ÷  ]
[  7 ]  [  8  ]  [  9  ]  [  ×  ]
[  4 ]  [  5  ]  [  6  ]  [  -  ]
[  1 ]  [  2  ]  [  3  ]  [  +  ]
[    0    ]       [  .  ]  [  =  ]
```

## ▶Como Executar

Pré-requisitos: Flutter SDK instalado. Veja [flutter.dev/docs/get-started](https://flutter.dev/docs/get-started).

```bash
# Clone o repositório
git clone <url-do-repositorio>
cd calculadora

# Instale as dependências
flutter pub get

# Execute o aplicativo
flutter run
```

## Licença

Este projeto está sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.

