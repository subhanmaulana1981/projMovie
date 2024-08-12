
import 'package:flutter/material.dart';
import 'package:proj_movie/konfigurasi/konfigurasi.dart';
import 'package:proj_movie/layanans/layanans.dart';
import 'package:proj_movie/models/akun.dart';
import 'package:proj_movie/models/movie.dart';
import 'package:proj_movie/widgets/memuat.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late Akun _akun;
  late String _stringImageURL;

  @override
  void initState() {
    super.initState();

    _akun = Akun();
    _stringImageURL = Konfigurasi().getImageURL();
  }

  @override
  Widget build(BuildContext context) {

    _akun = Provider.of<Akun>(
      context,
      listen: true
    );

    ThemeData themeData = Theme.of(context);
    ColorScheme colorScheme = themeData.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profilPengguna",
          style: themeData.textTheme.titleLarge,
        ),
        elevation: 8.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // profil
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "profil",
                  style: themeData.textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),

                CircleAvatar(
                  child: Image.network(
                    "$_stringImageURL${_akun.avatar!.tmdb!.avatarPath}",
                    width: 128,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),

                Text("name: ${_akun.name}"),
                const SizedBox(
                  height: 8.0,
                ),

                Text("userName: ${_akun.username}"),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
            const Divider(),

            // watchList movie(s)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "watchList",
                  style: themeData.textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),

                FutureBuilder<List<Movie>>(
                  future: Layanan().watchList(),
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
                              child: Image.network(
                                "$_stringImageURL${asyncSnapshot.data![index].posterPath}",
                                // width: 128,
                                fit: BoxFit.contain,
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
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
            const Divider(),

            // fav movie(s)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "favorite",
                  style: themeData.textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.inverseSurface
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),

                FutureBuilder<List<Movie>>(
                  future: Layanan().favorite(),
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
                            childAspectRatio: 0.67
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 8.0,
                              margin: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "$_stringImageURL${asyncSnapshot.data![index].posterPath}",
                                fit: BoxFit.contain,
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
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
