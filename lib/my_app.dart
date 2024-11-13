import 'package:flutter/material.dart';
import 'package:flutterimcapp/pages/main_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remover banner de DEBUG
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
        // primarySwatch: Colors.red,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        // useMaterial3: true,
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
      ),
      home: const MainPage(),
    );
  }
}
