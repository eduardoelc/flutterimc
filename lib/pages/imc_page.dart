import 'package:flutter/material.dart';
import 'package:flutterimcapp/model/card_detail.dart';
import 'package:flutterimcapp/model/pessoa_model.dart';
import 'package:flutterimcapp/repositories/card_detail_repository.dart';
import 'package:flutterimcapp/repositories/dados_pessoa_repository.dart';
import 'package:flutterimcapp/repositories/imc_classificacao_repository.dart';
import 'package:flutterimcapp/shared/widgets/column_info.dart';
import 'package:intl/intl.dart';

class ImcPage extends StatefulWidget {
  final int id;
  const ImcPage({super.key, required this.id});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  late int pessoaId;
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();
  var classificacao = "Normal";
  PessoaModel? selectedPessoa;

  var cardDetailRepository = CardDetailRepository();
  var classificacaoRepo = ImcClassificacaoRepository();
  var pessoaRepository = DadosPessoaRepository();

  DateTime now = DateTime.now();

  List<CardDetail> _cardDetail = [];

  @override
  void initState() {
    pessoaId = widget.id;
    carregarDados();
    super.initState();
  }

  // Carrega os dados do repositório
  void carregarDados() async {
    try {
      List<CardDetail> dados = await cardDetailRepository.listar(pessoaId);
      PessoaModel? pessoa = await pessoaRepository.obterPessoa(pessoaId);
      setState(() {
        _cardDetail = dados;
        if (pessoa != null) {
          selectedPessoa = pessoa;
        } else {
          selectedPessoa = null;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados: $e')),
      );
    }
  }

  void limparDados() {
    setState(() {
      _cardDetail.clear();
    });
  }

  void adicionarRegistro() async {
    if (alturaController.text.isEmpty || pesoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    if (selectedPessoa == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione uma pessoa')),
      );
      return;
    }

    try {
      double altura = double.parse(alturaController.text);
      double peso = double.parse(pesoController.text);
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

  void deletarRegistro(CardDetail cardDetail, int index) async {
    try {
      setState(() {
        _cardDetail.removeAt(index);
      });

      await cardDetailRepository.remover(cardDetail.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Item "${cardDetail.id}" removido com sucesso.')),
      );
      limparDados();
      carregarDados();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover o registro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro de IMC',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          alturaController.text = selectedPessoa!.altura.toString();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Calcular IMC"),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            selectedPessoa?.id == null
                ? Container()
                : Card(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4,
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      title: Container(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black87, width: 2)),
                        ),
                        child: Text(
                          selectedPessoa!.nome,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InfoColumn(
                                label: 'Peso Inicial',
                                value: "${selectedPessoa!.peso} kg",
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              InfoColumn(
                                label: 'Altura Inicial',
                                value: "${selectedPessoa!.altura} m",
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              InfoColumn(
                                label: 'IMC Inicial',
                                value: selectedPessoa!.imc.toStringAsFixed(2),
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InfoColumn(
                                label: 'Clarificação Inicial',
                                value: classificacaoRepo
                                    .obterClassificacao(selectedPessoa!.imc),
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            Expanded(
              child: _cardDetail.isEmpty
                  ? const Center(
                      child: Text(
                        "Sem Registro",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _cardDetail.length,
                      itemBuilder: (BuildContext context, int index) {
                        var cardDetail = _cardDetail[index];
                        return Dismissible(
                          key: Key(cardDetail.id.toString()),
                          onDismissed: (DismissDirection direction) {
                            deletarRegistro(cardDetail, index);
                          },
                          direction: DismissDirection.horizontal,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.timer_outlined),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InfoColumn(
                                            label:
                                                DateFormat('dd/MM/yyyy - hh:mm')
                                                    .format(DateTime.parse(
                                                        cardDetail.data)),
                                            value: "",
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InfoColumn(
                                            label: "Peso (kg)",
                                            value: cardDetail.peso.toString(),
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center),
                                        InfoColumn(
                                            label: "Altura (m)",
                                            value: cardDetail.altura.toString(),
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
            ),
          ],
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
