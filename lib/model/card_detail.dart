class CardDetail {
  int _id;
  int _pessoaId;
  double _peso;
  double _altura;
  double _imc;
  String _data;
  String _classificacao;

  CardDetail(this._id, this._pessoaId, this._peso, this._altura, this._imc,
      this._data, this._classificacao);

  int get id => _id;
  set id(int id) {
    _id = id;
  }

  int get pessoaId => _pessoaId;
  set pessoaId(int pessoaId) {
    _pessoaId = pessoaId;
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

  String get data => _data;
  set data(String data) {
    _data = data;
  }

  String get classificacao => _classificacao;
  set classificacao(String classificacao) {
    _classificacao = classificacao;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'pessoaId': _pessoaId,
      'peso': _peso,
      'altura': _altura,
      'imc': _imc,
      'data': _data,
      'classificacao': _classificacao,
    };
  }

  factory CardDetail.fromMap(Map<String, dynamic> map) {
    return CardDetail(
      map['id'],
      map['pessoaId'],
      map['peso'],
      map['altura'],
      map['imc'],
      map['data'] is String ? DateTime.parse(map['data']) : map['data'],
      map['classificacao'],
    );
  }

  // Sobrescrevendo o método toString() para representar o objeto como uma string legível
  @override
  String toString() {
    return 'CardDetail{id: $_id, pessoaId: $_pessoaId, peso: $_peso, altura: $_altura, imc: $_imc, data: $_data, classificacao: $_classificacao}';
  }
}
