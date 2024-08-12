
class Tmdb {
  // properti
  String? avatarPath;

  // konstruksi
  Tmdb({
    this.avatarPath,
  });

  Tmdb.fromJson(Map<String, dynamic> json) {
    avatarPath = json["avatar_path"];
  }

}