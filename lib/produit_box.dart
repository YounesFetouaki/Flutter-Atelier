import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProduitBox extends StatelessWidget {
  final String nomProduit;
  final String description; // <-- AJOUTÉ
  final String photoUrl;
  final bool selProduit;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? delProduit;
  final void Function()? onTap; // Pour la page de détails

  const ProduitBox({
    super.key,
    required this.nomProduit,
    required this.description, // <-- AJOUTÉ
    required this.photoUrl,
    this.selProduit = false,
    this.onChanged,
    this.delProduit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Slidable(
        // Action de suppression
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: delProduit,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(25),
            ),
          ],
        ),
        // Le corps de l'élément
        child: InkWell(
          onTap: onTap, // Gère le clic pour les détails
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              // Couleur plus douce que le jaune vif
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.blueGrey[100]!, width: 1),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: selProduit,
                  onChanged: onChanged,
                ),
                // --- Affichage de l'image ---
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      photoUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      // Gestion des erreurs (URL mauvaise)
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey[400]),
                        );
                      },
                      // Indicateur de chargement
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.0)),
                        );
                      },
                    ),
                  ),
                ),
                // --- Textes (Nom et Description) ---
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nomProduit,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        // <-- AJOUTÉ
                        description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        maxLines: 2, // Affiche sur 2 lignes max
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // Marge
              ],
            ),
          ),
        ),
      ),
    );
  }
}
