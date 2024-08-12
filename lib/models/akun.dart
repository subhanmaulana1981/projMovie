
import 'package:proj_movie/models/avatar.dart';

// kelas akun
class Akun {

  // properti(es)
  Avatar? avatar; // sibling
  int? id;
  String? iso6391;
  String? iso31661;
  String? name;
  bool? includeAdult;
  String? username;

  // konstruksi
  Akun({
    this.avatar, // sibling
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  Akun.fromJson(Map<String, dynamic> json) {
    // sibling (avatar)
    avatar = (json["avatar"] != null)
      ? Avatar.fromJson(json["avatar"])
      : null;

    id = json["id"];
    iso6391 = json["iso6391"];
    iso31661 = json["31661"];
    name = json["name"];
    includeAdult = json["include_adult"];
    username = json["username"];
  }

}
