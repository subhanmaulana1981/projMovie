
import 'package:proj_movie/models/belongs_to_collection.dart';
import 'package:proj_movie/models/genre.dart';
import 'package:proj_movie/models/production_company.dart';
import 'package:proj_movie/models/production_country.dart';
import 'package:proj_movie/models/spoken_language.dart';

class MovieDetail {

  // properti(es)
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  // konstruksi
  MovieDetail({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  // method
  MovieDetail.fromJson(Map<String, dynamic> json) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];

    // sibling (belongsToCollection)
    belongsToCollection = (json["belongs_to_collection"] != null)
      ? BelongsToCollection.fromJson(json["belongs_to_collection"])
      : null;

    budget = json["budget"];

    // children (genre(s))
    if (json["genres"] != null) {
      genres = <Genre>[];
      json["genres"].forEach((genre) {
        genres!.add(Genre.fromJson(genre));
      });
    }

    homepage = json["homepage"];
    id = json["id"];
    imdbId = json["imdb_id"];

    // children (string)
    if (json["origin_country"] != null) {
      originCountry = <String>[];
      json["origin_country"].forEach((country) {
        originCountry!.add(country);
      });
    }

    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];

    // children (productionCompany)
    if (json["production_companies"] != null) {
      productionCompanies = <ProductionCompany>[];
      json["production_companies"].forEach((productionCompany) {
        productionCompanies!.add(ProductionCompany.fromJson(productionCompany));
      });
    }

    // children (productionCountry)
    if (json["production_countries"] != null) {
      productionCountries = <ProductionCountry>[];
      json["production_countries"].forEach((productionCountry) {
        productionCountries!.add(ProductionCountry.fromJson(productionCountry));
      });
    }

    releaseDate = json["release_date"];
    revenue = json["revenue"];
    runtime = json["runtime"];

    // children (spokenLanguage)
    if (json["spoken_languages"] != null) {
      spokenLanguages = <SpokenLanguage>[];
      json["spoken_languages"].forEach((spokenLanguage) {
        spokenLanguages!.add(SpokenLanguage.fromJson(spokenLanguage));
      });
    }

    status = json["status"];
    tagline = json["tagline"];
    title = json["title"];
    video = json["video"];
    voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }
}
