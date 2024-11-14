import 'package:flutter/material.dart';
import 'package:flutterimcapp/pages/reristro_ultimo_imc.dart';
import 'package:flutterimcapp/shared/widgets/custon_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Histórico de IMC",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: const CustonDrawer(),
      body: const Column(
        children: [
          Expanded(
            // child: ImcPage(),
            child: ReristroUltimoImcPage(),
          ),
        ],
      ),
    );
  }
}
