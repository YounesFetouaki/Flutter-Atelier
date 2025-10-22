class Produit {
  String nom;
  String description; // <-- AJOUTÉ
  double prix;
  String photo;
  bool selectionne;

  // Constructeur mis à jour
  Produit({
    required this.nom,
    required this.description, // <-- AJOUTÉ
    required this.prix,
    required this.photo,
    this.selectionne = false, // Par défaut, un produit n'est pas sélectionné
  });

  // Pour un affichage facile lors du débogage
  @override
  String toString() {
    return '$nom - $prix €';
  }
}
