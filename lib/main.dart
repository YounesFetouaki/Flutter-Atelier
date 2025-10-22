import 'package:flutter/material.dart';
import '/produits_list.dart'; // Importer l'écran principal

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Utiliser Material 3 pour un look moderne
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const ProduitsList(), // L'écran d'accueil
      debugShowCheckedModeBanner: false,
    );
  }
}
