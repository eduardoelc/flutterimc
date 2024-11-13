import 'package:flutter/material.dart';
import 'package:flutterimcapp/model/pessoa_model.dart';
import 'package:flutterimcapp/repositories/dados_pessoa_repository.dart';

class DadosPessoaPage extends StatefulWidget {
  @override
  _DadosPessoaPageState createState() => _DadosPessoaPageState();
}

class _DadosPessoaPageState extends State<DadosPessoaPage> {
  final nomeController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String imcResultado = "";
  final DadosPessoaRepository pessoaRepository =
      DadosPessoaRepository(); // Repositório
  PessoaModel? pessoaEditando; // Para armazenar a pessoa editada

  @override
  void initState() {
    super.initState();
    // Verifica se já existe uma pessoa cadastrada
    _carregarDados();
  }

  void _carregarDados() async {
    pessoaEditando = pessoaRepository.obterPessoa();
    print(pessoaEditando.toString());
    if (pessoaEditando != null) {
      nomeController.text = pessoaEditando!.nome;
      pesoController.text = pessoaEditando!.peso.toString();
      alturaController.text = pessoaEditando!.altura.toString();
      imcResultado = "IMC: ${pessoaEditando!.imc.toStringAsFixed(2)}";
    }
  }

  void _salvarCadastro() {
    if (formKey.currentState?.validate() ?? false) {
      String nome = nomeController.text;
      double peso = double.tryParse(pesoController.text) ?? 0;
      double altura = double.tryParse(alturaController.text) ?? 0;

      // Criando ou atualizando a pessoa
      PessoaModel pessoa = PessoaModel(nome, peso, altura, 0);
      pessoaRepository.calcularIMC(pessoa);

      // Salva ou atualiza a pessoa no repositório
      pessoaRepository.adicionarOuAtualizarPessoa(pessoa);

      setState(() {
        imcResultado = "IMC Calculado: ${pessoa.imc.toStringAsFixed(2)}";
      });

      // Limpar os campos após salvar
      nomeController.clear();
      pesoController.clear();
      alturaController.clear();
      pessoaEditando = pessoa;
      _carregarDados();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(pessoaEditando == null ? "Cadastrar Pessoa" : "Editar Pessoa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Campo Nome
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              // Campo Peso
              TextFormField(
                controller: pesoController,
                decoration: const InputDecoration(labelText: "Peso (kg)"),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o peso';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              // Campo Altura
              TextFormField(
                controller: alturaController,
                decoration: const InputDecoration(labelText: "Altura (m)"),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a altura';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Botão Salvar
              ElevatedButton(
                onPressed: _salvarCadastro,
                child: Text(pessoaEditando == null
                    ? "Salvar Cadastro"
                    : "Atualizar Cadastro"),
              ),
              const SizedBox(height: 20),
              // Exibir o IMC calculado
              if (imcResultado.isNotEmpty) Text(imcResultado),
            ],
          ),
        ),
      ),
    );
  }
}
