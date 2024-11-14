import 'package:flutterimcapp/model/card_detail.dart';
import 'package:flutterimcapp/repositories/sqlite/sqlite_database.dart';

class CardDetailRepository {
  final List<CardDetail> _cardDetails = [];
  Future<List<CardDetail>> listar(int pessoaId) async {
    var db = await SQLiteDatabase().getDatabase();

    var result = await db.rawQuery(
        "SELECT * FROM registro_imc WHERE pessoaId = $pessoaId ORDER BY id DESC");

    for (var el in result) {
      _cardDetails.add(CardDetail(
          int.parse(el["id"].toString()),
          int.parse(el["pessoaId"].toString()),
          double.parse(el["peso"].toString()),
          double.parse(el["altura"].toString()),
          double.parse(el["imc"].toString()),
          el["data"].toString(),
          el['classificacao'].toString()));
    }

    return _cardDetails;
  }

  Future<List<CardDetail>> listarUltimoRegistro() async {
    var db = await SQLiteDatabase().getDatabase();

    // var result = await db.rawQuery(
    //     "SELECT ri.* FROM registro_imc ri INNER JOIN ( SELECT pessoaId, MAX(data) AS ultima_data FROM registro_imc GROUP BY pessoaId) AS ultimos_registros ON ri.pessoaId = ultimos_registros.pessoaId AND ri.id = ultimos_registros.ultima_id");
    var result = await db.rawQuery('''SELECT ri.*
    FROM registro_imc ri
    INNER JOIN (
        SELECT MAX(id) AS ultima_id
        FROM registro_imc
        GROUP BY pessoaId
    ) AS ultimos_registros
    ON ri.id = ultimos_registros.ultima_id''');

    for (var el in result) {
      _cardDetails.add(CardDetail(
          int.parse(el["id"].toString()),
          int.parse(el["pessoaId"].toString()),
          double.parse(el["peso"].toString()),
          double.parse(el["altura"].toString()),
          double.parse(el["imc"].toString()),
          el["data"].toString(),
          el['classificacao'].toString()));
    }

    return _cardDetails;
  }

  Future<void> salvar(CardDetail cardDetail) async {
    var db = await SQLiteDatabase().getDatabase();
    db.rawInsert(
        "INSERT INTO registro_imc (pessoaId, peso, altura, imc, data, classificacao) VALUES(?, ?, ?, ?, ?, ?)",
        [
          cardDetail.pessoaId,
          cardDetail.peso,
          cardDetail.altura,
          cardDetail.imc,
          cardDetail.data,
          cardDetail.classificacao
        ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDatabase().getDatabase();
    db.delete(
      'registro_imc',
      where: 'id = ?',
      whereArgs: [id],
    );
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
