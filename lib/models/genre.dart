
class Genre {

  // properti(es)
  int? id;
  String? name;

  // konstruksi
  Genre({
    this.id,
    this.name
  });

  // method
  Genre.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
