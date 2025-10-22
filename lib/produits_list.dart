import 'package:flutter/material.dart';
import '/add_produit.dart';
import '/produit_box.dart';
import '/produit.dart'; // Importe la classe

// --- NOUVEAU : Page de détails (mise à jour) ---
// (Mise dans ce fichier pour simplifier)
class ProduitDetailPage extends StatelessWidget {
  final Produit produit;
  const ProduitDetailPage({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(produit.nom)),
      body: SingleChildScrollView(
        // Permet de scroller si le contenu dépasse
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                produit.photo,
                width: double.infinity, // Prend toute la largeur
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  color: Colors.grey[200],
                  child: Icon(Icons.image_not_supported,
                      color: Colors.grey[400], size: 50),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(produit.nom,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("${produit.prix.toStringAsFixed(2)} €", // Formate le prix
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            const Text("Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
                // <-- AJOUTÉ
                produit.description,
                style: const TextStyle(
                    fontSize: 16, height: 1.5) // Hauteur de ligne
                ),
          ],
        ),
      ),
    );
  }
}
// --- FIN Page de détails ---

// --- Écran principal de la liste ---
class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  // La liste utilise maintenant la classe Produit
  List<Produit> liste = [
    Produit(
      nom: "Ordinateur Portable",
      description: "Un PC puissant pour le travail et le jeu.", // <-- AJOUTÉ
      prix: 1299.99,
      photo: "https://picsum.photos/200/300?random=1",
      selectionne: false,
    ),
    Produit(
      nom: "Smartphone",
      description: "Le dernier modèle avec un écran OLED.", // <-- AJOUTÉ
      prix: 799.50,
      photo: "https://picsum.photos/200/300?random=2",
      selectionne: true,
    ),
    Produit(
      nom: "Clavier Mécanique",
      description: "Touches Cherry MX pour une frappe parfaite.", // <-- AJOUTÉ
      prix: 150.00,
      photo: "https://picsum.photos/200/300?random=3",
      selectionne: false,
    ),
  ];

  // Controllers pour le dialogue
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController(); // <-- AJOUTÉ
  final TextEditingController prixController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  // Met à jour la sélection
  void onChanged(bool? value, int index) {
    setState(() {
      liste[index].selectionne = value ?? false;
    });
  }

  // Sauvegarde le nouveau produit
  void saveProduit() {
    setState(() {
      final nouveauProduit = Produit(
        nom: nomController.text,
        description: descriptionController.text, // <-- AJOUTÉ
        prix: double.tryParse(prixController.text) ?? 0.0,
        photo: photoController.text.isEmpty
            // Fournit une image aléatoire si le champ est vide
            ? "https://picsum.photos/200/300?random=${DateTime.now().millisecondsSinceEpoch}"
            : photoController.text,
      );
      liste.add(nouveauProduit);
    });
    Navigator.of(context).pop();
  }

  // Affiche le dialogue d'ajout
  void addProduit() {
    // Vider les champs avant d'afficher
    nomController.clear();
    descriptionController.clear(); // <-- AJOUTÉ
    prixController.clear();
    photoController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AddProduit(
          nomController: nomController,
          descriptionController: descriptionController, // <-- Passé
          prixController: prixController,
          photoController: photoController,
          onAdd: saveProduit,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Supprime un produit (par glissement)
  void delProduit(int index) {
    setState(() {
      liste.removeAt(index);
    });
  }

  // Supprime tous les produits sélectionnés
  void deleteSelected() {
    setState(() {
      liste.removeWhere((produit) => produit.selectionne == true);
    });
  }

  // Affiche la page de détails
  void showDetails(Produit produit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProduitDetailPage(produit: produit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion de Produits"),
        actions: [
          // Bouton pour supprimer la sélection (bonus)
          IconButton(
            onPressed: deleteSelected,
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: "Supprimer la sélection",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduit,
        tooltip: "Ajouter un produit",
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: liste.length,
        itemBuilder: (context, index) {
          final produit = liste[index];
          // Passe toutes les nouvelles infos au ProduitBox
          return ProduitBox(
            nomProduit: produit.nom,
            description: produit.description, // <-- Passé
            photoUrl: produit.photo,
            selProduit: produit.selectionne,
            onChanged: (value) => onChanged(value, index),
            delProduit: (context) => delProduit(index),
            onTap: () => showDetails(produit), // Gère le clic
          );
        },
      ),
    );
  }
}
