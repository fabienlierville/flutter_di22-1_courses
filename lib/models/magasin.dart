class Magasin {
  int? id;
  String nom;

  Magasin({
    this.id,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nom': this.nom,
    };
  }

  factory Magasin.fromMap(Map<String, dynamic> map) {
    return Magasin(
      id: map['id'] as int,
      nom: map['nom'] as String,
    );
  }
}