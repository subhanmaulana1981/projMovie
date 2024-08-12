
import 'package:proj_movie/models/gravatar.dart';
import 'package:proj_movie/models/tmdb.dart';

// kelas avatar
class Avatar {
  // properti(es)
  Gravatar? gravatar; // sibling
  Tmdb? tmdb; // sibling

  // konstruksi
  Avatar({
    this.gravatar,
    this.tmdb,
  });

  Avatar.fromJson(Map<String, dynamic> json) {
    // sibling (gravatar)
    gravatar = (json["gravatar"] != null)
      ? Gravatar.fromJson(json["gravatar"])
      : null;

    // sibling (tmdb)
    tmdb = (json["tmdb"] != null)
      ? Tmdb.fromJson(json["tmdb"])
      : null;
  }

}
