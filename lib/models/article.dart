class Article{
  int? id;
  String nom;
  double prix;
  String image;
  int magasin; //Sera notre clef étrangère

  Article({
    this.id,
    required this.nom,
    required this.prix,
    required this.image,
    required this.magasin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nom': this.nom,
      'prix': this.prix,
      'image': this.image,
      'magasin': this.magasin,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as int,
      nom: map['nom'] as String,
      prix: map['prix'] as double,
      image: map['image'] as String,
      magasin: map['magasin'] as int,
    );
  }
}