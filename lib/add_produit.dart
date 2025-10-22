import 'package:flutter/material.dart';

class AddProduit extends StatelessWidget {
  final TextEditingController nomController;
  final TextEditingController descriptionController; // <-- AJOUTÉ
  final TextEditingController prixController;
  final TextEditingController photoController;
  final void Function()? onAdd;
  final void Function()? onCancel;

  const AddProduit({
    super.key,
    required this.nomController,
    required this.descriptionController, // <-- AJOUTÉ
    required this.prixController,
    required this.photoController,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter un produit"),
      content: SizedBox(
        // Hauteur ajustée pour le champ supplémentaire
        height: 310,
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nom du produit",
              ),
            ),
            const SizedBox(height: 10), // Espace
            TextField(
              // <-- AJOUTÉ
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Description",
              ),
              maxLines: 2, // Permet une description plus longue
            ),
            const SizedBox(height: 10), // Espace
            TextField(
              controller: prixController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Prix",
              ),
            ),
            const SizedBox(height: 10), // Espace
            TextField(
              controller: photoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "URL de la photo",
              ),
            ),
            const Spacer(), // Pousse les boutons en bas
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: onAdd,
                  child: const Text("Add"),
                ),
                MaterialButton(
                  onPressed: onCancel,
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
