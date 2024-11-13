class CardDetail {
  int _id;
  double _peso;
  double _altura;
  double _imc;
  DateTime _data;
  String _classificacao;

  CardDetail(this._id, this._peso, this._altura, this._imc, this._data,
      this._classificacao);

  int get id => _id;
  set id(int id) {
    _id = id;
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

  DateTime get data => _data;
  set data(DateTime data) {
    _data = data;
  }

  String get classificacao => _classificacao;
  set classificacao(String classificacao) {
    _classificacao = classificacao;
  }

  // Sobrescrevendo o método toString() para representar o objeto como uma string legível
  @override
  String toString() {
    return 'CardDetail{id: $_id, peso: $_peso, altura: $_altura, imc: $_imc, data: $_data, classificacao: $_classificacao}';
  }
}
