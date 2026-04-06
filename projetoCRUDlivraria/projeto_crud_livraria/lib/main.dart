import 'dart:io';


List<Livro> livros = [];

class Livro{
    String _titulo;
    String _autor;
    String _anoDePublicacao;
    String _id;

    Livro(this._titulo, this._autor, this._anoDePublicacao, this._id);

    String? getTitulo() {
        return this._titulo;
    }

    void setTitulo(String novoTitulo) {
        this._titulo = novoTitulo;
    }

    String? getAutor() {
        return this._autor;
    }

    void setAutor(String novoAutor) {
        this._autor = novoAutor;
    }

    String? getAnoDePuplicacao() {
        return this._anoDePublicacao;
    }

    void setAnoDePublicacao(String novoAno) {
        this._anoDePublicacao = novoAno;
    }

    String? getId() {
        return this._id;
    }

    void setId(String novoId) {
        this._id = novoId;
    }
}

void cadastrarLivro(String titulo, String autor, String anoDePublicacao, String id) {
    Livro livro = Livro(titulo, autor, anoDePublicacao, id);
    livros.add(livro);
}

Livro? getLivro(String nomeLivro) {
    try{
        Livro? livro = livros.firstWhere((e) => e.getTitulo()?.toLowerCase() == nomeLivro.toLowerCase());
        return livro;
    } catch (e) {
        print("Livro não encontrado.");
        return null;
    }

}

void listarLivros(){
    for (var livro in livros) {
        print("Titulo: ${livro.getTitulo()}");
        print("Autor: ${livro.getAutor()}");
        print("Ano de publicação: ${livro.getAnoDePuplicacao()}");
        print("Identificação ISBN: ${livro.getId()}");
        print("="*50);
        print("\n");
    }
}

void listarLivroUnico(String nomeLivro) {
    Livro? livro = getLivro(nomeLivro);
    print("Titulo: ${livro?.getTitulo()}");
    print("Autor: ${livro?.getAutor()}");
    print("Ano de publicação: ${livro?.getAnoDePuplicacao()}");
    print("Identificação ISBN: ${livro?.getId()}");
    print("="*50);
    print("\n");
}


void main() {

    cadastrarLivro("Duna", "Frank Herbert", "1965", "978-85-7657-101-8");
    cadastrarLivro("O Senhor dos Aneis: A sociedade do Anel", "J. R. R. Tolkien", "1954", "978-972-1-04102-8");
    cadastrarLivro("Fundação", "Isaac Asimov", "1951", "9788576574835");

    int? escolha = 0;
    while (escolha != 5) {
  
        print("1 - Cadastrar livro");
        print("2 - Listar livros");
        print("3 - Atualizar livro");
        print("4 - Remover livro");
        print("5 - Sair");
        stdout.write("Escolha o n° de uma opção: ");
        String? entrada = stdin.readLineSync();
        if(entrada == null || entrada.trim().isEmpty) { 
            stderr.writeln("Escolha entre 1-5!!");
            continue;
        }
        try{
            escolha = int.parse(entrada);
            if(escolha <= 0 || escolha > 5) {
                stderr.writeln("Escolha entre 1-5!!");
            }

        } catch(e) {
            stderr.writeln("Escolha entre 1-5!!");
        }

        switch (escolha) {
            case 1:
                print("Cadastrar livro");
                stdout.write("Digite o título do livro: ");
                String? entradaNome = stdin.readLineSync();
                
                stdout.write("Digite o autor do livro: ");
                String? entradaAutor = stdin.readLineSync();
                
                stdout.write("Digite o ano de publicação do livro: ");
                String? entradaAno = stdin.readLineSync();
                
                stdout.write("Digite o ISBN do livro: ");
                String? entradaId = stdin.readLineSync();

                cadastrarLivro(entradaAno)
                
                break;
        }
    }
    listarLivroUnico("elantris");

}