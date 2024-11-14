import 'package:flutter/material.dart';
import 'package:flutterimcapp/model/card_detail.dart';
import 'package:flutterimcapp/model/pessoa_model.dart';
import 'package:flutterimcapp/pages/imc_page.dart';
import 'package:flutterimcapp/repositories/card_detail_repository.dart';
import 'package:flutterimcapp/repositories/dados_pessoa_repository.dart';
import 'package:flutterimcapp/repositories/imc_classificacao_repository.dart';
import 'package:flutterimcapp/shared/widgets/column_info.dart';
import 'package:intl/intl.dart';

class ReristroUltimoImcPage extends StatefulWidget {
  const ReristroUltimoImcPage({super.key});

  @override
  State<ReristroUltimoImcPage> createState() => _ReristroUltimoImcPageState();
}

class _ReristroUltimoImcPageState extends State<ReristroUltimoImcPage> {
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();
  var classificacao = "Normal";
  PessoaModel? selectedPessoa;

  var cardDetailRepository = CardDetailRepository();
  var classificacaoRepo = ImcClassificacaoRepository();
  var pessoaRepository = DadosPessoaRepository();

  DateTime now = DateTime.now();

  List<CardDetail> _cardDetail = [];
  List<PessoaModel> _pessoas = [];

  @override
  void initState() {
    super.initState();
    limparDados();
    carregarDados();
  }

  // Carrega os dados do repositório
  void carregarDados() async {
    try {
      List<CardDetail> dados =
          await cardDetailRepository.listarUltimoRegistro();
      List<PessoaModel> lista = await pessoaRepository.obterPessoas();
      setState(() {
        _cardDetail = dados;
        _pessoas = lista;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados: $e')),
      );
    }
  }

  void limparDados() {
    setState(() {
      selectedPessoa = null;
      _cardDetail.clear(); // Limpa os registros de IMC
      _pessoas.clear(); // Limpa a lista de pessoas
    });
  }

  void adicionarRegistro() async {
    if (alturaController.text.isEmpty || pesoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      double altura = double.parse(alturaController.text.replaceAll(",", "."));
      double peso = double.parse(pesoController.text.replaceAll(",", "."));
      double imc = cardDetailRepository.calcularIMC(peso, altura);

      String classificacao = classificacaoRepo.obterClassificacao(imc);

      await cardDetailRepository.salvar(CardDetail(0, selectedPessoa!.id, peso,
          altura, imc, now.toIso8601String(), classificacao));

      Navigator.pop(context);
      limparDados();
      carregarDados();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o registro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _pessoas.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {},
            )
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                alturaController.clear();
                pesoController.clear();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Calcular IMC"),
                      content: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButtonFormField<int>(
                              value: selectedPessoa?.id,
                              hint: const Text("Selecione uma Pessoa"),
                              items: _pessoas.map((pessoa) {
                                return DropdownMenuItem<int>(
                                  value: pessoa.id,
                                  child: Text(pessoa.nome),
                                );
                              }).toList(),
                              onChanged: (int? id) {
                                setState(() {
                                  selectedPessoa = _pessoas
                                      .firstWhere((pessoa) => pessoa.id == id);
                                  if (selectedPessoa != null) {
                                    alturaController.text =
                                        selectedPessoa!.altura.toString();
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Selecione uma pessoa";
                                }
                                return null;
                              },
                            ),
                            _buildTextField(
                              hintText: "Informe o Peso (kg)",
                              controller: pesoController,
                            ),
                            _buildTextField(
                              hintText: "Informe a Altura (m)",
                              controller: alturaController,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: adicionarRegistro,
                          child: const Text("Salvar"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _cardDetail.isEmpty
                  ? const Center(
                      child: Text(
                        "Sem Registro",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _cardDetail.length,
                      itemBuilder: (BuildContext context, int index) {
                        var cardDetail = _cardDetail[index];
                        var pessoa = _pessoas
                            .firstWhere((p) => p.id == cardDetail.pessoaId);

                        if (pessoa.hasId()) {
                          return const SizedBox();
                        }

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImcPage(id: pessoa.id),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'card_${cardDetail.id}',
                            child: Card(
                              elevation: 8,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InfoColumn(
                                        label: pessoa.nome,
                                        value: "",
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.timer_outlined),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InfoColumn(
                                            label: "",
                                            value:
                                                DateFormat('dd/MM/yyyy - hh:mm')
                                                    .format(DateTime.parse(
                                                        cardDetail.data)),
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            font: 16),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InfoColumn(
                                            label: "Altura (m)",
                                            value: cardDetail.altura.toString(),
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center),
                                        InfoColumn(
                                            label: "Peso (kg)",
                                            value: cardDetail.peso.toString(),
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center),
                                        InfoColumn(
                                            label: "IMC",
                                            value: cardDetail.imc
                                                .toStringAsFixed(2),
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InfoColumn(
                                            label: "Classificação",
                                            value: cardDetail.classificacao,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para construir o campo de texto
  Widget _buildTextField(
      {required String hintText, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        controller: controller,
      ),
    );
  }
}
