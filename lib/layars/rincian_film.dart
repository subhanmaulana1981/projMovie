
import 'package:flutter/material.dart';
import 'package:proj_movie/konfigurasi/konfigurasi.dart';
import 'package:proj_movie/layanans/layanans.dart';
import 'package:proj_movie/models/movie.dart';
import 'package:proj_movie/models/movie_detail.dart';
import 'package:proj_movie/widgets/memuat.dart';

class RincianFilm extends StatefulWidget {
  const RincianFilm({super.key});

  @override
  State<RincianFilm> createState() => _RincianFilmState();
}

class _RincianFilmState extends State<RincianFilm> {
  late String _stringImageURL;
  late String _stringMovieID;

  @override
  void initState() {
    super.initState();

    _stringImageURL = Konfigurasi().getImageURL();
    _stringMovieID = "";
  }

  @override
  Widget build(BuildContext context) {
    _stringMovieID = ModalRoute
        .of(context)!
        .settings
        .arguments as String;

    ThemeData themeData = Theme.of(context);
    ColorScheme colorScheme = themeData.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "film | rincian",
          style: themeData.textTheme.titleLarge,
        ),
        elevation: 8.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "detail movie",
              style: themeData.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.inverseSurface
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

            FutureBuilder<MovieDetail>(
              future: Layanan().movieDetails(_stringMovieID),
              initialData: MovieDetail(),
              builder: (BuildContext context, AsyncSnapshot<MovieDetail> asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Memuat();

                } else if (asyncSnapshot.connectionState == ConnectionState.done) {
                  if (asyncSnapshot.data!.id == null) {
                    return const Text("data tidak diTemukan!");

                  } else if (asyncSnapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // detail movie
                        Image.network(
                          "$_stringImageURL${asyncSnapshot.data!.posterPath}",
                          width: 0.75 * MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),

                        Text(
                          asyncSnapshot.data!.title.toString(),
                          style: themeData.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.inverseSurface
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: asyncSnapshot.data!.genres!.map((genre) {
                            return Text(" | ${genre.name.toString()} | ");
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),

                        Text(
                          asyncSnapshot.data!.overview.toString(),
                          textAlign: TextAlign.justify,
                          softWrap: true,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    );

                  } else if (asyncSnapshot.hasError) {
                    return Text(asyncSnapshot.error.toString());

                  } else {
                    return const Memuat();
                  }

                } else {
                  return const Memuat();
                }
              }
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Divider(),

            Text(
              "similar movie(s)",
              style: themeData.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.inverseSurface
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

            FutureBuilder<List<Movie>>(
              future: Layanan().similarMovies(_stringMovieID),
              initialData: const <Movie>[],
              builder: (BuildContext context, AsyncSnapshot<List<Movie>> asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Memuat();

                } else if (asyncSnapshot.connectionState == ConnectionState.done) {
                  if (asyncSnapshot.data!.isEmpty) {
                    return const Text("data tidak diTemukan!");

                  } else if (asyncSnapshot.hasData) {
                    return GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.67,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 8.0,
                          margin: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Image.network(
                                  "$_stringImageURL${asyncSnapshot.data![index].posterPath}",
                                  width: 0.67 * (MediaQuery.of(context).size.width),
                                  fit: BoxFit.contain,
                                ),
                              ),

                              Text(asyncSnapshot.data![index].title.toString())
                            ],
                          ),
                        );
                      },
                      itemCount: asyncSnapshot.data!.length,
                    );

                  } else if (asyncSnapshot.hasError) {
                    return Text(asyncSnapshot.error.toString());

                  } else {
                    return const Memuat();
                  }

                } else {
                  return const Memuat();
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
