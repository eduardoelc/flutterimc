import 'package:flutterimcapp/model/pessoa_model.dart';

class DadosPessoaRepository {
  PessoaModel? _pessoa;

  // Função para obter a pessoa cadastrada
  PessoaModel? obterPessoa() {
    return _pessoa;
  }

  // Função para adicionar ou atualizar a pessoa
  void adicionarOuAtualizarPessoa(PessoaModel pessoa) {
    _pessoa = pessoa;
  }

  // Função para remover a pessoa (caso deseje remover)
  void removerPessoa() {
    _pessoa = null;
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
