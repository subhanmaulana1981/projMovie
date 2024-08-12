
class BelongsToCollection {

  // properti(es)
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  // konstruksi
  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath
  });

  // method
  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    posterPath = json["poster_path"];
    backdropPath = json["backdrop_path"];
  }
}
