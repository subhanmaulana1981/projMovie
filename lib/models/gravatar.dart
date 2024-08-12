
class Gravatar {
  // properti
  String? hash;

  // konstruksi
  Gravatar({
    this.hash,
  });

  Gravatar.fromJson(Map<String, dynamic> json) {
    hash = json["hash"];
  }

}