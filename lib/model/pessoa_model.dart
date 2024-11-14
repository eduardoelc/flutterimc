class PessoaModel {
  int _id;
  String _nome;
  double _peso;
  double _altura;
  double _imc;

  PessoaModel(this._id, this._nome, this._peso, this._altura, this._imc);

  // Getters e Setters
  int get id => _id;
  set id(int id) {
    _id = id;
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

  double get imc => _imc;
  set imc(double imc) {
    _imc = imc;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nome': _nome,
      'peso': _peso,
      'altura': _altura,
      'imc': _imc,
    };
  }

  factory PessoaModel.fromMap(Map<String, dynamic> map) {
    return PessoaModel(
      map['id'],
      map['nome'],
      map['peso'],
      map['altura'],
      map['imc'],
    );
  }

  bool hasId() {
    return _id.isNaN;
  }

  @override
  String toString() {
    return 'Nome: $_nome, Peso: $_peso, Altura: $_altura, IMC: $_imc';
  }
}
