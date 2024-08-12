
class ProductionCountry {

  // properti(es)
  String? iso31661;
  String? name;

  // konstruksi
  ProductionCountry({
    this.iso31661,
    this.name
  });

  // method
  ProductionCountry.fromJson(Map<String, dynamic> json) {
    iso31661 = json["iso_3166_1"];
    name = json["name"];
  }

}
