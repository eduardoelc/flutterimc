import 'package:flutter/material.dart';
import 'package:flutterimcapp/pages/dados_pessoa_page.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.image_outlined),
                        )
                      ],
                    );
                  });
            },
            child: const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25.0,
                  foregroundImage: NetworkImage(
                      "https://i0.wp.com/www.vidanatural.org.br/wp-content/uploads/2019/12/%C3%8Dndice-de-Massa-Corporal-scaled.jpg"),
                ),
                accountName: Text("Email"),
                accountEmail: Text("Email@email.com")),
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Dados Pessoais"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DadosPessoaPage()));
            },
          ),
        ],
      ),
    );
  }
}
