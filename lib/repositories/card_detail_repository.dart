import 'package:flutterimcapp/model/card_detail.dart';

class CardDetailRepository {
  final List<CardDetail> _cardDetails = [];

  Future<void> adicionar(CardDetail cardDetail) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cardDetails.add(cardDetail);
  }

  // Future<void> alterar(String id, double peso, double altura, double imc, DateTime data) async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.peso = peso;
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.altura = altura;
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.imc = imc;
  //   _cardDetails.where((CardDetail) => CardDetail.id == id).first.data = data;
  // }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cardDetails
        .remove(_cardDetails.where((cardDetail) => cardDetail.id == id).first);
  }

  Future<List<CardDetail>> listar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _cardDetails;
  }
}
