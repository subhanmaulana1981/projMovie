
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proj_movie/konfigurasi/konfigurasi.dart';
import 'package:proj_movie/layanans/layanans.dart';
import 'package:proj_movie/models/akun_states.dart';
import 'package:proj_movie/models/movie.dart';
import 'package:proj_movie/widgets/info_simpan.dart';
import 'package:proj_movie/widgets/ke_luar.dart';
import 'package:proj_movie/widgets/laci.dart';
import 'package:proj_movie/widgets/memuat.dart';
import 'package:provider/provider.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late String _stringImageURL;
  late bool _isRefresh;

  @override
  void initState() {
    super.initState();

    _isRefresh = false;
    _stringImageURL = Konfigurasi().getImageURL();

    // compiler's trick | cleanUp code
    if (_isRefresh == false) _isRefresh = false;
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Text>[
            Text(
              "nonton",
              style: themeData.textTheme.titleLarge!.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold
              ),
            ),

            Text(
              "IN",
              style: themeData.textTheme.titleLarge!.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.end,
            layoutBehavior: ButtonBarLayoutBehavior.padded,
            children: <IconButton>[
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const KeLuar();
                    }
                  );
                },
                icon: const Icon(Icons.logout),
                tooltip: "ke luar",
              )
            ],
          )
        ],
        centerTitle: true,
        elevation: 8.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "now playing",
            style: themeData.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.inverseSurface
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),

          Flexible(
            // flex: 3,
            // fit: FlexFit.loose,
            child: FutureBuilder<List<Movie>>(
              future: Layanan().nowPlaying(),
              initialData: const <Movie>[],
              builder: (BuildContext context, AsyncSnapshot<List<Movie>> asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Memuat();

                } else if (asyncSnapshot.connectionState == ConnectionState.done) {
                  if (asyncSnapshot.data!.isEmpty) {
                    return const Text("data tidak diTemukan!");

                  } else if (asyncSnapshot.hasData) {
                    return CarouselSlider(
                      items: asyncSnapshot.data!.map((movie) {
                        int index = asyncSnapshot.data!.indexOf(movie);

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "/rincianFilm",
                              arguments: asyncSnapshot.data![index].id.toString()
                             );
                          },
                          child: Image.network(
                            "$_stringImageURL${asyncSnapshot.data![index].posterPath!}",
                            width: 0.67 * (MediaQuery.of(context).size.width),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        // height: 64,
                        aspectRatio: 1 / 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        // enlargeCenterPage: true,
                        // enlargeFactor: 0.2,
                        scrollPhysics: const ScrollPhysics(),
                      ),
                    );

                  } else if (asyncSnapshot.hasError) {
                    return Text(asyncSnapshot.error.toString());

                  } else {
                    return const Memuat();
                  }

                } else {
                  return const Memuat();
                }
              },
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Divider(),

          // daftar popularMovies
          Text(
            "popular movies",
            style: themeData.textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.inverseSurface,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),

          Flexible(
            // flex: 3,
            // fit: FlexFit.loose,
            child: FutureBuilder<List<Movie>>(
              future: Layanan().popularMovies(),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex: 5,
                                fit: FlexFit.loose,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/rincianFilm",
                                      arguments: asyncSnapshot.data![index].id.toString()
                                    );
                                  },
                                  child: Image.network(
                                    "$_stringImageURL${asyncSnapshot.data![index].posterPath}",
                                    width: 0.67 * (MediaQuery.of(context).size.width),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FutureProvider<AccountStates>.value(
                                      value: Layanan().accountStates(asyncSnapshot.data![index].id.toString()),
                                      initialData: AccountStates(),
                                      catchError: (BuildContext context, Object? exception) {
                                        return AccountStates();
                                      },
                                      updateShouldNotify: (previous, current) {
                                        bool shouldNotify = (previous != current);
                                        return shouldNotify;
                                      },
                                      child: ButtonBar(
                                        children: <Widget>[
                                          Consumer<AccountStates>(
                                            builder: (BuildContext context, AccountStates accountStates, Widget? child) {
                                              return IconButton(
                                                onPressed: () {
                                                  Layanan().addToFavorite(
                                                    "movie",
                                                    asyncSnapshot.data![index].id!,
                                                    true
                                                  ).then((value) {
                                                    if (kDebugMode) print("status_message: ${value.statusMessage.toString()}");
                                                  }).whenComplete(() {
                                                    setState(() {
                                                      _isRefresh = true;
                                                    });

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return const InfoSimpan();
                                                      }
                                                    );
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: (accountStates.favorite == true)
                                                    ? Colors.pink
                                                    : colorScheme.onPrimaryContainer,
                                                ),
                                                tooltip: "film favorit",
                                              );
                                            }
                                          ),

                                          Consumer<AccountStates>(
                                            builder: (BuildContext context, AccountStates accountStates, Widget? child) {
                                              return IconButton(
                                                onPressed: () {
                                                  Layanan().addToWatchList(
                                                    "movie",
                                                    asyncSnapshot.data![index].id!,
                                                    true
                                                  ).then((value) {
                                                    if (kDebugMode) print("status_message: ${value.statusMessage.toString()}");
                                                  }).whenComplete(() {
                                                    setState(() {
                                                      _isRefresh = true;
                                                    });

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return const InfoSimpan();
                                                      }
                                                    );
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.checklist,
                                                  color: (accountStates.watchlist == true)
                                                    ? Colors.green
                                                    : colorScheme.onPrimaryContainer,
                                                ),
                                                tooltip: "daftar putar",
                                              );
                                            },
                                          ),
                                      
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.download),
                                            tooltip: "simpan gambar",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
          ),
          /*const SizedBox(
            height: 8.0,
          ),*/
        ],
      ),
      drawer: const Laci(),
      resizeToAvoidBottomInset: true,
    );
  }
}
