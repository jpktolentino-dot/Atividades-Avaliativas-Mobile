import 'dart:io';


List<Livro> livros = [];

class Livro{
    String? _titulo;
    String? _autor;
    String? _anoDePublicacao;
    String? _id;

    Livro(this._titulo, this._autor, this._anoDePublicacao, this._id);

    String? getTitulo() {
        return this._titulo;
    }

    void setTitulo(String? novoTitulo) {
        this._titulo = novoTitulo;
    }

    String? getAutor() {
        return this._autor;
    }

    void setAutor(String? novoAutor) {
        this._autor = novoAutor;
    }

    String? getAnoDePuplicacao() {
        return this._anoDePublicacao;
    }

    void setAnoDePublicacao(String? novoAno) {
        this._anoDePublicacao = novoAno;
    }

    String? getId() {
        return this._id;
    }

    void setId(String? novoId) {
        this._id = novoId;
    }
}

void cadastrarLivro(String? titulo, String? autor, String? anoDePublicacao, String? id) {
    Livro? livro = Livro(titulo, autor, anoDePublicacao, id);
    livros.add(livro);
}

Livro? getLivro(String? nomeLivro) {
    try{
        Livro? livro = livros.firstWhere((e) => e.getTitulo()?.toLowerCase() == nomeLivro?.toLowerCase());
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

void listarLivroUnico(String? nomeLivro) {
    Livro? livro = getLivro(nomeLivro);

    print("="*50);
    print("Titulo: ${livro?.getTitulo()}");
    print("Autor: ${livro?.getAutor()}");
    print("Ano de publicação: ${livro?.getAnoDePuplicacao()}");
    print("Identificação ISBN: ${livro?.getId()}");
    print("="*50);
    print("\n");
}

bool removerLivro(String? nomeLivro) {
    bool removido = livros.remove(livros.firstWhere((e) => e.getTitulo()?.toLowerCase() == nomeLivro?.toLowerCase()));
    return removido;
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
                print("="*50);
                stdout.write("Digite o título do livro: ");
                String? entradaNome = stdin.readLineSync();
                
                stdout.write("Digite o autor do livro: ");
                String? entradaAutor = stdin.readLineSync();
                
                stdout.write("Digite o ano de publicação do livro: ");
                String? entradaAno = stdin.readLineSync();
                
                stdout.write("Digite o ISBN do livro: ");
                String? entradaId = stdin.readLineSync();

                cadastrarLivro(entradaNome, entradaAutor, entradaAno, entradaId);
                
                print("="*50);
                print("\n");

                break;
            
            case 2: 
                print("Listar livros");
                print("="*50);
                listarLivros();
                break;
            
            case 3: 
                print("Atualizar livro");
                print("="*50);
                stdout.write("Digite o título do livro: ");
                String? entradaNome = stdin.readLineSync();
                print("="*50);
                listarLivroUnico(entradaNome);
                Livro? livro = livros.firstWhere((e) => e.getTitulo()?.toLowerCase() == entradaNome?.toLowerCase());

                int? decidirAtualizar = 0;
                while(decidirAtualizar != 5) {
                    print("1 - Atualizar Titulo");
                    print("2 - Atualizar Autor");
                    print("3 - Atualizar Ano de publicação");
                    print("4 - Atualizar ISBN");
                    print("5 - Sair");
                    stdout.write("Escolha o n° de uma opção: ");
                    String? entrada2 = stdin.readLineSync();
                    if(entrada2 == null || entrada2.trim().isEmpty) { 
                        stderr.writeln("Escolha entre 1-5!!");
                        continue;
                    }
                    try{
                        decidirAtualizar = int.parse(entrada2);
                        if(decidirAtualizar <= 0 || decidirAtualizar > 5) {
                            stderr.writeln("Escolha entre 1-5!!");
                        }

                    } catch(e) {
                        stderr.writeln("Escolha entre 1-5!!");
                    }

                    switch (decidirAtualizar) {
                        case 1:
                            stdout.write("Digite o título do livro: ");
                            String? entradaNome = stdin.readLineSync();
                            livro?.setTitulo(entradaNome);
                            break;

                        case 2:
                            stdout.write("Digite o autor do livro: ");
                            String? entradaAutor = stdin.readLineSync();
                            livro?.setAutor(entradaAutor);
                            break;

                        case 3:
                            stdout.write("Digite o ano de publicação do livro: ");
                            String? entradaAno = stdin.readLineSync();
                            livro?.setAnoDePublicacao(entradaAno);
                            break;

                        case 4:
                            stdout.write("Digite o ISBN do livro: ");
                            String? entradaId = stdin.readLineSync();
                            livro?.setId(entradaId);
                            break;
                    }
                }
                break; 
                
            case 4:
                print("="*50);
                print("Remover livro");
                print("="*50);
                stdout.write("Digite o título do livro: ");
                String? entradaNome = stdin.readLineSync();
                print("="*50);
                if(removerLivro(entradaNome)) {
                    print("livro removido com sucesso!");
                    listarLivros();
                    break;
                }else {
                    print("livro não removido!");
                    print("="*50);
                    print("="*50);
                    getLivro(entradaNome);
                    listarLivros();
                    break;
                }
        }
    }
    

}