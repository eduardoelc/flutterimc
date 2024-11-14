import 'dart:convert';
import 'package:flutterimcapp/model/pessoa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DadosPessoaRepository {
  Future<List<PessoaModel>> obterPessoas() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? pessoasJson = storage.getString('pessoas');

    if (pessoasJson != null) {
      List<dynamic> listaMap = json.decode(pessoasJson);
      return listaMap.map((map) => PessoaModel.fromMap(map)).toList();
    }
    return [];
  }

  Future<PessoaModel?> obterPessoa(int id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? pessoasJson = storage.getString('pessoas');

    if (pessoasJson != null) {
      List<dynamic> listaMap = json.decode(pessoasJson);

      try {
        var pessoaMap = listaMap.firstWhere(
          (map) => map['id'] == id,
        );

        return PessoaModel.fromMap(pessoaMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> adicionarOuAtualizarPessoa(PessoaModel pessoa) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    List<PessoaModel> pessoas = await obterPessoas();

    int index = pessoas.indexWhere((p) => p.id == pessoa.id);
    if (index != -1) {
      pessoas[index] = pessoa;
    } else {
      pessoas.add(pessoa);
    }

    List<Map<String, dynamic>> listaMap =
        pessoas.map((p) => p.toMap()).toList();
    String pessoasJson = json.encode(listaMap);
    await storage.setString('pessoas', pessoasJson);
  }

  Future<void> removerPessoa(int id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    List<PessoaModel> pessoas = await obterPessoas();

    pessoas.removeWhere((p) => p.id == id);

    List<Map<String, dynamic>> listaMap =
        pessoas.map((p) => p.toMap()).toList();
    String pessoasJson = json.encode(listaMap);
    await storage.setString('pessoas', pessoasJson);
  }

  // Método para calcular IMC
  void calcularIMC(PessoaModel pessoa) {
    if (pessoa.altura > 0) {
      pessoa.imc = pessoa.peso / (pessoa.altura * pessoa.altura);
    } else {
      pessoa.imc = 0;
    }
  }
}
