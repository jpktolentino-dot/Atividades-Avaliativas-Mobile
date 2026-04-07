# 📚 Sistema de Gerenciamento de Biblioteca (CLI em Dart)

Este projeto consiste em um sistema simples de gerenciamento de
biblioteca desenvolvido em **Dart**, executado diretamente no terminal.

O objetivo é aplicar, na prática, os conceitos de **Programação
Orientada a Objetos (POO)** por meio da implementação de um CRUD
completo para gerenciamento de livros.

------------------------------------------------------------------------

## 🎯 Objetivo

-   Aplicar conceitos de POO em Dart\
-   Desenvolver um sistema interativo via terminal\
-   Implementar operações de CRUD (Create, Read, Update, Delete)\
-   Manipular listas de objetos

------------------------------------------------------------------------

## 🛠️ Tecnologias Utilizadas

-   **Dart**
-   Execução via terminal (CLI)
-   Biblioteca padrão `dart:io` para entrada e saída de dados

------------------------------------------------------------------------

## 📌 Funcionalidades

O sistema permite:

-   📖 Cadastrar um livro\
-   📋 Listar todos os livros\
-   🔍 Buscar e visualizar um livro específico\
-   ✏️ Atualizar informações de um livro\
-   ❌ Remover um livro

------------------------------------------------------------------------

## 🧠 Conceitos de POO Aplicados

O projeto utiliza os seguintes conceitos:

-   **Classes** → Representação do objeto `Livro`\
-   **Atributos privados** → Encapsulamento com `_`\
-   **Getters e Setters** → Controle de acesso aos dados\
-   **Construtor** → Inicialização dos objetos\
-   **Lista de objetos** → Armazenamento dos livros

------------------------------------------------------------------------

## 🧩 Estrutura do Sistema

### 📚 Classe `Livro`

Representa um livro dentro do sistema.

**Atributos:**

-   `titulo`
-   `autor`
-   `anoDePublicacao`
-   `id` (ISBN)

Todos os atributos são privados e acessados via getters e setters.

------------------------------------------------------------------------

## ⚙️ Funcionamento do Sistema

O sistema roda em loop no terminal apresentando o seguinte menu:

    1 - Cadastrar livro
    2 - Listar livros
    3 - Atualizar livro
    4 - Remover livro
    5 - Sair

O usuário interage digitando as opções e fornecendo os dados
solicitados.

------------------------------------------------------------------------

## 💻 Exemplo de Uso

    1 - Cadastrar livro
    Digite o título do livro: Duna
    Digite o autor do livro: Frank Herbert
    Digite o ano de publicação: 1965
    Digite o ISBN: 978-85-7657-101-8

    2 - Listar livros

    Titulo: Duna
    Autor: Frank Herbert
    Ano de publicação: 1965
    Identificação ISBN: 978-85-7657-101-8

------------------------------------------------------------------------

## ⚠️ Observações

-   Os dados são armazenados apenas em memória (lista), ou seja, não há
    persistência em banco de dados\
-   A busca e remoção são feitas com base no **título do livro**\
-   O sistema já inicia com alguns livros pré-cadastrados para teste


------------------------------------------------------------------------
