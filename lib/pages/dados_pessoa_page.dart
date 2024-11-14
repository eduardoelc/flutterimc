import 'package:flutter/material.dart';
import 'package:flutterimcapp/model/pessoa_model.dart';
import 'package:flutterimcapp/repositories/dados_pessoa_repository.dart';

class DadosPessoaPage extends StatefulWidget {
  final PessoaModel? pessoa;

  DadosPessoaPage({this.pessoa});

  @override
  _DadosPessoaPageState createState() => _DadosPessoaPageState();
}

class _DadosPessoaPageState extends State<DadosPessoaPage> {
  final nomeController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String imcResultado = "";

  final DadosPessoaRepository pessoaRepository = DadosPessoaRepository();
  PessoaModel? pessoaEditando;

  @override
  void initState() {
    super.initState();
    if (widget.pessoa != null) {
      // Se uma pessoa for passada para edição
      pessoaEditando = widget.pessoa;
      nomeController.text = pessoaEditando!.nome;
      pesoController.text = pessoaEditando!.peso.toString();
      alturaController.text = pessoaEditando!.altura.toString();
      imcResultado = "IMC: ${pessoaEditando!.imc.toStringAsFixed(2)}";
    }
  }

  void _salvarCadastro() async {
    if (formKey.currentState?.validate() ?? false) {
      String nome = nomeController.text;
      double peso =
          double.tryParse(pesoController.text.replaceAll(",", ".")) ?? 0;
      double altura =
          double.tryParse(alturaController.text.replaceAll(",", ".")) ?? 0;

      // Se estiver editando, atualiza, senão cria uma nova pessoa
      int id = pessoaEditando?.id ??
          DateTime.now().millisecondsSinceEpoch; // ID único para nova pessoa
      PessoaModel pessoa = PessoaModel(id, nome, peso, altura, 0);
      pessoaRepository.calcularIMC(pessoa);

      // Salva ou atualiza a pessoa no repositório
      await pessoaRepository.adicionarOuAtualizarPessoa(pessoa);

      setState(() {
        imcResultado = "IMC Calculado: ${pessoa.imc.toStringAsFixed(2)}";
      });

      // Limpar os campos após salvar
      nomeController.clear();
      pesoController.clear();
      alturaController.clear();

      Navigator.pop(context); // Retorna à tela de listagem
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (pessoaEditando == null ? "Cadastrar Pessoa" : "Editar Pessoa"),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o peso';
                  }
                  if (double.tryParse(value.replaceAll(",", ".")) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              // Campo Altura
              TextFormField(
                controller: alturaController,
                decoration: const InputDecoration(labelText: "Altura (m)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a altura';
                  }
                  if (double.tryParse(value.replaceAll(",", ".")) == null) {
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
