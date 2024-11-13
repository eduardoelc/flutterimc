import 'package:flutter/material.dart';
import 'package:flutterimcapp/model/card_detail.dart';
import 'package:flutterimcapp/repositories/card_detail_repository.dart';
import 'package:flutterimcapp/repositories/imc_classificacao_repository.dart';
import 'package:flutterimcapp/shared/widgets/text_label.dart';
import 'package:intl/intl.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();
  var cardDetailRepository = CardDetailRepository();

  var classificacaoRepo = ImcClassificacaoRepository();

  DateTime now = DateTime.now();

  List<CardDetail> _cardDetail = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  // Carrega os dados do repositório
  void carregarDados() async {
    try {
      final dados = await cardDetailRepository.listar();
      setState(() {
        _cardDetail = dados;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados: $e')),
      );
    }
  }

  // Função para construir o campo de texto
  Widget _buildTextField(
      {required String hintText, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: hintText),
        controller: controller,
      ),
    );
  }

  // Função para adicionar um novo registro
  void _adicionarRegistro() async {
    if (alturaController.text.isEmpty || pesoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      double altura = double.parse(alturaController.text);
      double peso = double.parse(pesoController.text);
      double imc = cardDetailRepository.calcularIMC(peso, altura);

      String classificacao = classificacaoRepo.obterClassificacao(imc);

      // Adiciona o novo registro ao repositório
      await cardDetailRepository
          .adicionar(CardDetail(0, peso, altura, imc, now, classificacao));
      Navigator.pop(context);
      carregarDados();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o registro: $e')),
      );
    }
  }

  // Função para deletar um item
  void _deletarRegistro(CardDetail cardDetail, int index) {
    cardDetailRepository.remove(cardDetail.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item "${cardDetail.id}" removido com sucesso.')),
    );

    setState(() {
      _cardDetail.removeAt(index);
    });

    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
                    onPressed: _adicionarRegistro,
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
                        // debugPrint(cardDetail.toString());
                        return Dismissible(
                          key: Key(cardDetail.id.toString()),
                          onDismissed: (DismissDirection direction) {
                            _deletarRegistro(cardDetail, index);
                          },
                          direction: DismissDirection.horizontal,
                          child: Hero(
                            tag: cardDetail.id,
                            child: Card(
                              elevation: 8,
                              shadowColor: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildInfoColumn(
                                            "Altura (m)",
                                            cardDetail.altura.toString(),
                                            CrossAxisAlignment.center),
                                        _buildInfoColumn(
                                            "Peso (kg)",
                                            cardDetail.peso.toString(),
                                            CrossAxisAlignment.center),
                                        _buildInfoColumn(
                                            "IMC",
                                            cardDetail.imc.toStringAsFixed(2),
                                            CrossAxisAlignment.center),
                                      ],
                                    ),
                                    _buildInfoColumn(
                                        "Classificação",
                                        cardDetail.classificacao,
                                        CrossAxisAlignment.start),
                                    _buildInfoColumn(
                                        "Data de Registro",
                                        DateFormat('dd/MM/yyyy - hh:mm')
                                            .format(cardDetail.data),
                                        CrossAxisAlignment.start),
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

  // Função para construir as informações
  Widget _buildInfoColumn(
      String label, String value, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        TextLabel(texto: label),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
      ],
    );
  }
}
