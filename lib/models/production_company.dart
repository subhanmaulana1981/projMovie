
class ProductionCompany {

  // properti(es)
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  // konstruksi
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry
  });

  // method
  ProductionCompany.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    logoPath = json["logo_path"];
    name = json["name"];
    originCountry = json["origin_country"];
  }

}