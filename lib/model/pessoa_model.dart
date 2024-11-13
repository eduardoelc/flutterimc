class PessoaModel {
  String _nome;
  double _peso;
  double _altura;
  double _imc;

  PessoaModel(this._nome, this._peso, this._altura, this._imc);

  // Getters e Setters
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

  double get imc => _imc;
  set imc(double imc) {
    _imc = imc;
  }

  @override
  String toString() {
    return 'Nome: $_nome, Peso: $_peso, Altura: $_altura, IMC: $_imc';
  }
}
