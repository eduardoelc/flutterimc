import 'package:flutter/material.dart';
import 'package:flutterimcapp/pages/card_page.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          alturaController.text = "";
          pesoController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar tarefa"),
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        right: -40,
                        top: -40,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                      Form(
                        key: Key('0'.toString()),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                child: const Text('Submitß'),
                                onPressed: () {
                                  // if (_formKey.currentState!.validate()) {
                                  //   _formKey.currentState!.save();
                                  // }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // TextField(
                  //   controller: pesoController,
                  // ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          // await tarefaRepository.salvar(TarefaHiveModel.criar(
                          //     descricaoController.text, false));
                          // Navigator.pop(context);
                          // obterTarefas();
                          // setState(() {});
                        },
                        child: const Text("Salvar"))
                  ],
                );
              });
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Column(
          children: [
            Expanded(
              child: CardPage(),
            ),
          ],
        ),
      ),
    );
  }
}
