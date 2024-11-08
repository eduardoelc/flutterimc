class CardDetail {
  int _id;
  double _peso;
  double _altura;
  double _imc;
  DateTime _data;

  CardDetail(this._id, this._peso, this._altura, this._imc, this._data);

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
}
