
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:proj_movie/konfigurasi/konfigurasi.dart';
import 'package:proj_movie/models/action_states.dart';
import 'package:proj_movie/models/akun.dart';
import 'package:proj_movie/models/akun_states.dart';
import 'package:proj_movie/models/movie.dart';
import 'package:proj_movie/models/movie_detail.dart';

class Layanan {

  // the moviedb org
  final String _stringURL = Konfigurasi().getAuthority();
  final String _stringAccessToken = Konfigurasi().getToken();
  final String _stringDefaultAkunId = Konfigurasi().getDefaultAkunId();

  // add to watch list
  Future<ActionStates> addToWatchList(
    String mediaType,
    int mediaId,
    bool watchList
  ) async {
    ActionStates actionStates = ActionStates();

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/account/$_stringDefaultAkunId/watchlist"
    );
    if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      Map<String, dynamic> watchListBody = {
        "media_type": mediaType,
        "media_id": mediaId,
        "watchlist": watchList
      };
      if (kDebugMode) print(jsonEncode(watchListBody));

      try {
        http.Response response = await http.post(
          uriURL,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          },
          body: jsonEncode(watchListBody)
        );
        if (response.statusCode == 200) {
          if (kDebugMode) print(response.body);
          actionStates = ActionStates.fromJson(jsonDecode(response.body));
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }

    });

    return actionStates;
  }

  // add to favorite
  Future<ActionStates> addToFavorite(
    String mediaType,
    int mediaId,
    bool favorite
  ) async {
    ActionStates actionStates = ActionStates();

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/account/$_stringDefaultAkunId/favorite"
    );
    if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      Map<String, dynamic> favoriteBody = {
        "media_type": mediaType,
        "media_id": mediaId,
        "favorite": favorite
      };
      if (kDebugMode) print(jsonEncode(favoriteBody));

      try {
        http.Response response = await http.post(
          uriURL,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          },
          body: jsonEncode(favoriteBody)
        );
        if (response.statusCode == 200) {
          actionStates = ActionStates.fromJson(jsonDecode(response.body));
          if (kDebugMode) print(response.body);

        } else {
          throw Exception("gagal tambah ke favorite!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return actionStates;
  }

  // account states
  Future<AccountStates> accountStates(String movieID) async {
    AccountStates accountStates = AccountStates();

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/movie/$movieID/account_states"
    );
    // if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          // if (kDebugMode) print(response.body);
          final resultBody = await jsonDecode(response.body);
          accountStates = AccountStates.fromJson(resultBody);

        } else {
          throw Exception("gagal ambil account states!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return accountStates;
  }

  // similarMovie
  Future<List<Movie>> similarMovies(String movieID) async {
    List<Movie> listSimilarMovies = <Movie>[];

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/movie/$movieID/similar",
      {
        "language": "en-US",
        "page": "1"
      }
    );
    // if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          // if (kDebugMode) print(response.body);
          final resultBody = jsonDecode(response.body);
          List listResultBody = resultBody["results"];
          listSimilarMovies = listResultBody.map((movie) {
            return Movie.fromJson(movie);
          }).toList();

        } else {
          throw Exception("gagal ambil similar movie(s)");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return listSimilarMovies;
  }

  // movieDetail
  Future<MovieDetail> movieDetails(String movieID) async {
    MovieDetail movieDetail = MovieDetail();

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/movie/$movieID",
      { "language": "en-US"}
    );
    // if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          // if (kDebugMode) print(response.body);
          final resultBody = await jsonDecode(response.body);
          movieDetail = MovieDetail.fromJson(resultBody);

        } else {
          throw Exception("gagal ambil detail movie!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return movieDetail;
  }

  // favorite
  Future<List<Movie>> favorite() async {
    List<Movie> listFavorite = <Movie>[];

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/account/$_stringDefaultAkunId/favorite/movies",
      {
        "language": "en-US",
        "page": "1",
        "sort_by": "created_at.asc"
      }
    );
    // if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          final resultBody = jsonDecode(response.body);
          // if (kDebugMode) print(response.body);

          List listResultBody = resultBody["results"];
          listFavorite = listResultBody.map((movie) {
            return Movie.fromJson(movie);
          }).toList();

        } else {
          throw Exception("gagal ambil favorite movie(s)!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return listFavorite;
  }

  // watchList
  Future<List<Movie>> watchList() async {
    List<Movie> listWatchList = <Movie>[];

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/account/$_stringDefaultAkunId/watchlist/movies",
      {
        "language": "en-US",
        "page": "1",
        "sort_by": "created_at.asc"
      }
    );
    // if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          final resultBody = jsonDecode(response.body);
          // if (kDebugMode) print(response.body);

          List listResultBody = resultBody["results"];
          listWatchList = listResultBody.map((movie) {
            return Movie.fromJson(movie);
          }).toList();

        } else {
          throw Exception("gagal ambil watchList!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
      }
    });

    return listWatchList;
  }

  // akunDetail
  Future<Akun> akunDetails() async {
    Akun akun = Akun();

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/account/$_stringDefaultAkunId"
    );
    // if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          final resultBody = jsonDecode(response.body);
          // if (kDebugMode) print(resultBody);
          akun = Akun.fromJson(resultBody);
          /*if (kDebugMode) print(akun.avatar!.tmdb!.avatarPath);
          if (kDebugMode) print(akun.name);
          if (kDebugMode) print(akun.username);*/

        } else {
          throw Exception("gagal ambil detail akun!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return akun;
  }

  // popularMovie
  Future<List<Movie>> popularMovies() async {
    List<Movie> listPopularMovies = <Movie>[];

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/movie/popular",
      {
        "language": "en-US",
        "page": "1"
      }
    );

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        final http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          final resultBody = jsonDecode(response.body);
          List listResultBody = resultBody["results"];
          listPopularMovies = listResultBody.map((movie) {
            return Movie.fromJson(movie);
          }).toList();

        } else {
          throw Exception("gagal ambil popularMovies!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return listPopularMovies;
  }

  // nowPlaying
  Future<List<Movie>> nowPlaying() async {
    List<Movie> listNowPlaying = <Movie>[];

    Uri uriURL = Uri.https(
      _stringURL,
      "/3/movie/now_playing",
      {
        "language": "en-US",
        "page": "1"
      }
    );
    // if (kDebugMode) print(uriURL);

    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        final http.Response response = await http.get(
          uriURL,
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $_stringAccessToken"
          }
        );
        if (response.statusCode == 200) {
          final resultBody = jsonDecode(response.body);
          List listResultBody = resultBody["results"];
          listNowPlaying = listResultBody.map((movie) {
            return Movie.fromJson(movie);
          }).toList();

        } else {
          throw Exception("gagal ambil nowPlaying!");
        }

      } catch(err, st) {
        if (kDebugMode) print(st);
        rethrow;
      }
    });

    return listNowPlaying;
  }

}