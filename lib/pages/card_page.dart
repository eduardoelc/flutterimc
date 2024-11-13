import 'package:flutter/material.dart';
import 'package:flutterimcapp/model/card_detail.dart';
import 'package:flutterimcapp/repositories/card_detail_repository.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var _cardDetail = const <CardDetail>[];
  var cardDetailRepository = CardDetailRepository();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    _cardDetail = await cardDetailRepository.listar();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: _cardDetail.isEmpty
              ? const LinearProgressIndicator()
              : InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CardDetailPage(
                    //               cardDetail: cardDetail!,
                    //             )));
                  },
                  child: ListView.builder(
                      itemCount: _cardDetail.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var cardDetail = _cardDetail[index];
                        return Hero(
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
                                    children: [
                                      // Image.network(
                                      //   cardDetail!.url,
                                      //   height: 20,
                                      // ),
                                      Text(
                                        'Altura: ${cardDetail.altura.toString()}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Peso: ${cardDetail.peso.toString()}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'IMC: ${cardDetail.imc.toString()}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      // Container(
                                      //     width: double.infinity,
                                      //     alignment: Alignment.centerRight,
                                      //     child: TextButton(
                                      //         onPressed: () {},
                                      //         child: const Text(
                                      //           cardDetail.data.toString(),
                                      //           style: TextStyle(
                                      //               decoration: TextDecoration
                                      //                   .underline),
                                      //         )))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ),
      ],
    );
  }
}
