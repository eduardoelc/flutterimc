//classe
class PessoaModel {
  //atributos
  String _nome = "";
  double _peso = 0;
  double _altura = 0;

  PessoaModel(String nome, double peso, double altura) {
    _nome = nome;
    _peso = peso;
    _altura = altura;
  }

  String get nome => _nome;
  set nome(String nome) {
    _nome = nome;
  }

  double get peso => _peso;
  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;
  set altura(double altura) {
    _altura = altura;
  }
}
