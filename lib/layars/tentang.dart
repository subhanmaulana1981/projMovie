
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Tentang extends StatefulWidget {
  const Tentang({super.key});

  @override
  State<Tentang> createState() => _TentangState();
}

class _TentangState extends State<Tentang> {

  Future<void> _launchURL(Uri uriURL) async {
    if (await canLaunchUrl(uriURL)) {
      await launchUrl(uriURL);
    } else {
      throw "tidak dapat launching $uriURL";
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "tentang",
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
            // nontonIN
            Image.asset(
              "assets/gambars/popcorn.png",
              width: 256,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 8.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Text>[
                Text(
                  "nonton",
                  style: themeData.textTheme.titleLarge!.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Text(
                  "IN",
                  style: themeData.textTheme.titleLarge!.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),

            const Text(
              "nontonIN adalah aplikasi virtual manajemen film sederhana yang memuat daftar film yang sedang kita tonton saat ini, film yang sedang trending saat ini, dapat membuat daftar film yang sudah kita tonton, dan daftar dari film favorit kita.",
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            const SizedBox(
              height: 8.0,
            ),

            const Text(
              "aplikasi sederhana dibangun hanya sebagai referensi dan tidak bermaksud untuk ditujukan sebagai aplikasi komersial pada umumnya.",
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            const SizedBox(
              height: 64.0,
            ),

            // the moviedb org
            Image.asset(
              "assets/gambars/blue_long_1.png",
              width: 256,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 8.0,
            ),

            const Text(
              "This product uses the TMDB API but is not endorsed or certified by TMDB. For more info:",
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              // layoutBehavior: ButtonBarLayoutBehavior.padded,
              children: <TextButton>[
                TextButton(
                  onPressed: () {
                    Uri uriURL = Uri.https("www.themoviedb.org");
                    _launchURL(uriURL);
                  },
                  child: const Text("https://www.themoviedb.org")
                )
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
