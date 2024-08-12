
class AccountStates {

  // properti(es)
  int? id; // movieID
  bool? favorite;
  bool? rated;
  bool? watchlist;

  // konstruksi
  AccountStates({
    this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  });

  // method
  AccountStates.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    favorite = json["favorite"];
    rated = json["rated"];
    watchlist = json["watchlist"];
  }

}
