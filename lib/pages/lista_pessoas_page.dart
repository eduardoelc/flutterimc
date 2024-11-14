import 'package:flutter/material.dart';
import 'package:flutterimcapp/model/pessoa_model.dart';
import 'package:flutterimcapp/pages/dados_pessoa_page.dart';
import 'package:flutterimcapp/repositories/dados_pessoa_repository.dart';
import 'package:flutterimcapp/repositories/imc_classificacao_repository.dart';
import 'package:flutterimcapp/shared/widgets/column_info.dart';

class ListaPessoasPage extends StatefulWidget {
  @override
  _ListaPessoasPageState createState() => _ListaPessoasPageState();
}

class _ListaPessoasPageState extends State<ListaPessoasPage> {
  var classificacaoRepo = ImcClassificacaoRepository();
  final DadosPessoaRepository pessoaRepository = DadosPessoaRepository();
  List<PessoaModel> pessoas = [];

  @override
  void initState() {
    super.initState();
    _carregarPessoas();
  }

  Future<void> _carregarPessoas() async {
    List<PessoaModel> lista = await pessoaRepository.obterPessoas();
    setState(() {
      pessoas = lista;
    });
  }

  // Função para editar
  void _editarPessoa(PessoaModel pessoa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DadosPessoaPage(pessoa: pessoa),
      ),
    ).then((_) => _carregarPessoas());
  }

  // Função para excluir
  void _excluirPessoa(int id) async {
    await pessoaRepository.removerPessoa(id);
    _carregarPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Pessoas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: pessoas.isEmpty
          ? const Center(child: Text("Nenhuma pessoa cadastrada"))
          : ListView.builder(
              itemCount: pessoas.length,
              itemBuilder: (context, index) {
                PessoaModel pessoa = pessoas[index];
                return Card(
                  color: Colors.grey.shade100,
                  margin: const EdgeInsets.all(8.0),
                  elevation: 8,
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
                        pessoa.nome,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                    subtitle: Container(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InfoColumn(
                                label: 'Peso Inicial',
                                value: "${pessoa.peso} kg",
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              InfoColumn(
                                label: 'Altura Inicial',
                                value: "${pessoa.altura} m",
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              InfoColumn(
                                label: 'IMC Inicial',
                                value: pessoa.imc.toStringAsFixed(2),
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
                                    .obterClassificacao(pessoa.imc),
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      onSelected: (value) {
                        if (value == 'editar') {
                          _editarPessoa(pessoa);
                        } else if (value == 'excluir') {
                          _excluirPessoa(pessoa.id);
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'editar',
                            child: Row(
                              children: [
                                Text(
                                  'Editar',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.blue),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.edit_document,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          const PopupMenuItem<String>(
                            value: 'excluir',
                            child: Row(
                              children: [
                                Text(
                                  'Excluir',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.red),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DadosPessoaPage(),
            ),
          ).then((_) => _carregarPessoas());
        },
        tooltip: 'Cadastrar Pessoa',
        child: const Icon(Icons.add),
      ),
    );
  }
}
