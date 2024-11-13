import 'package:flutterimcapp/model/card_detail.dart';

class CardDetailRepository {
  final List<CardDetail> _cardDetails = [];

  Future<void> adicionar(CardDetail cardDetail) async {
    await Future.delayed(const Duration(milliseconds: 100));
    cardDetail.id = _cardDetails.isEmpty ? 1 : _cardDetails.last.id + 1;
    _cardDetails.add(cardDetail);
  }

  // Future<void> alterar(String id, double peso, double altura, double imc, DateTime data) async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.peso = peso;
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.altura = altura;
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.imc = imc;
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.data = data;
  // }

  Future<void> remove(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _cardDetails.removeWhere((cardDetail) => cardDetail.id == id);
  }

  Future<List<CardDetail>> listar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _cardDetails;
  }

  double calcularIMC(double peso, double altura) {
    if (peso <= 0) {
      throw ArgumentError('O peso deve ser maior que zero');
    } else if (altura <= 0) {
      throw ArgumentError('A altura deve ser maior que zero');
    }
    return double.parse((peso / (altura * altura)).toStringAsFixed(2));
  }
}
