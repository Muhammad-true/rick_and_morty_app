class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String location;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.location,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
      location: json['location']['name'],
    );
  }
}
