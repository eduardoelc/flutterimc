import 'package:flutter/material.dart';
import 'package:flutterimcapp/pages/dados_pessoa_page.dart';
import 'package:flutterimcapp/pages/lista_pessoas_page.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25.0,
              foregroundImage: NetworkImage(
                  "https://i0.wp.com/www.vidanatural.org.br/wp-content/uploads/2019/12/%C3%8Dndice-de-Massa-Corporal-scaled.jpg"),
            ),
            accountName: Text("Email"),
            accountEmail: Text("Email@email.com"),
          ),
          ListTile(
            title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(
                      Icons.person_add,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Cadastrar Pessoa",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DadosPessoaPage()));
            },
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Lista de Pessoas",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListaPessoasPage()));
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Texto na parte inferior',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
