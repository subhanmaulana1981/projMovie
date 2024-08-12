
import 'package:flutter/material.dart';
import 'package:proj_movie/layanans/layanans.dart';
import 'package:proj_movie/layars/profil.dart';
import 'package:proj_movie/layars/rincian_film.dart';
import 'package:proj_movie/layars/tentang.dart';
import 'package:proj_movie/models/akun.dart';
import 'package:proj_movie/models/movie.dart';
import 'package:proj_movie/models/movie_detail.dart';
import 'package:proj_movie/wrapper.dart';
import 'package:provider/provider.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Colors.brown
    );

    return MultiProvider(
      providers: <FutureProvider>[
        // similar movie(s)
        FutureProvider<List<Movie>>.value(
          value: Layanan().similarMovies("533535"),
          initialData: const <Movie>[],
          catchError: (BuildContext context, Object? exception) {
            return <Movie>[];
          },
          updateShouldNotify: (previous, current) {
            bool shouldNotify = (previous != current);
            return shouldNotify;
          },
        ),

        // detail movie
        FutureProvider<MovieDetail>.value(
          value: Layanan().movieDetails("533535"),
          initialData: MovieDetail(),
          catchError: (BuildContext context, Object? exception) {
            return MovieDetail();
          },
          updateShouldNotify: (previous, current) {
            bool shouldNotify = (previous != current);
            return shouldNotify;
          },
        ),

        // fav movie(s)
        FutureProvider<List<Movie>>.value(
          value: Layanan().favorite(),
          initialData: const <Movie>[],
          catchError: (BuildContext context, Object? exception) {
            return <Movie>[];
          },
          updateShouldNotify: (previous, current) {
            bool shouldNotify = (previous != current);
            return shouldNotify;
          },
        ),

        // watchList movie(s)
        FutureProvider<List<Movie>>.value(
          value: Layanan().watchList(),
          initialData: const <Movie>[],
          catchError: (BuildContext context, Object? exception) {
            return <Movie>[];
          },
          updateShouldNotify: (previous, current) {
            bool shouldNotify = (previous != current);
            return shouldNotify;
          },
        ),

        // akun details
        FutureProvider<Akun>.value(
          value: Layanan().akunDetails(),
          initialData: Akun(),
          catchError: (BuildContext context, Object? exception) {
            return Akun();
          },
          updateShouldNotify: (previous, current) {
            bool shouldNotify = (previous != current);
            return shouldNotify;
          },
        ),

        // popular movies
        FutureProvider<List<Movie>>.value(
          value: Layanan().popularMovies(),
          initialData: const <Movie>[],
          catchError: (BuildContext context, Object? exception) {
            return <Movie>[];
          },
          updateShouldNotify: (previous, current) {
            bool shouldNotify = (previous != current);
            return shouldNotify;
          },
        ),

        // now playing
        FutureProvider<List<Movie>>.value(
          value: Layanan().nowPlaying(),
          initialData: const <Movie>[],
          catchError: (BuildContext context, Object? exception) {
            return <Movie>[];
          },
          updateShouldNotify: (previous, current) {
            bool shouldNotify = (previous != current);
            return shouldNotify;
          },
        ),
      ],
      child: MaterialApp(
        home: const Wrapper(),
        routes: {
          "/rincianFilm": (context) {
            return const RincianFilm();
          },

          "/profil": (context) {
            return const Profil();
          },

          "/tentang": (context) {
            return const Tentang();
          },
        },
        theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
          fontFamily: "OpenSans"
        ),
      ),
    );
  }
}
