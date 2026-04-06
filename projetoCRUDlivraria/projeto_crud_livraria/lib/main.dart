
List<Livro> livros = [];

class Livro{
    String titulo;
    String autor;
    String anoDePublicacao;
    String id;

    Livro(this.titulo, this.autor, this.anoDePublicacao, this.id);

    String getTitulo() {
        return this.titulo;
    }

    void setTitulo(String novoTitulo) {
        this.titulo = novoTitulo;
    }

    String getAutor() {
        return this.autor;
    }

    void setAutor(String novoAutor) {
        this.autor = novoAutor;
    }

    String getAnoDePuplicacao() {
        return this.anoDePublicacao;
    }

    void setAnoDePublicacao(String novoAno) {
        this.anoDePublicacao = novoAno;
    }

    String getId() {
        return this.id;
    }

    void setId(String novoId) {
        this.id = novoId;
    }
}

void cadastrarLivro(String titulo, String autor, String anoDePublicacao, String id) {
    Livro livro = Livro(titulo, autor, anoDePublicacao, id);
    livros.add(livro);
}

Livro? getLivro(String nomeLivro) {
    try{
        Livro livro = livros.firstWhere((e) => e.getTitulo().toLowerCase() == nomeLivro.toLowerCase());
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


void main() {

    cadastrarLivro("Elantris", "Brian Sanderson", "2005", "0765311771");
    cadastrarLivro("O Hobbit", "J. R. R. Tolkien", "1937", "000711835-X");
    cadastrarLivro("Fundação", "Isaac Asimov", "1951", "9788576574835");
    //listarLivros();
    Livro? livroBuscado = getLivro("elantris");
    print("hello world");
}