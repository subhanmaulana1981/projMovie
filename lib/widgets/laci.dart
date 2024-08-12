
import 'package:flutter/material.dart';
import 'package:proj_movie/konfigurasi/konfigurasi.dart';
import 'package:proj_movie/models/akun.dart';
import 'package:proj_movie/widgets/ke_luar.dart';
import 'package:provider/provider.dart';

class Laci extends StatefulWidget {
  const Laci({super.key});

  @override
  State<Laci> createState() => _LaciState();
}

class _LaciState extends State<Laci> {
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

    return Drawer(
      backgroundColor: colorScheme.primaryContainer,
      elevation: 8.0,
      child: ListView(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        // padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          // akun pengguna
          Consumer<Akun>(
            builder: (BuildContext context, Akun akun, Widget? child) {
              return UserAccountsDrawerHeader(
                // margin: EdgeInsets.all(8.0),
                currentAccountPicture: CircleAvatar(
                  child: Image.network(
                    "$_stringImageURL${_akun.avatar!.tmdb!.avatarPath.toString()}",
                    width: 72,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                currentAccountPictureSize: const Size(72, 72),
                accountName: Text("${_akun.name}"),
                accountEmail: Text("${_akun.username}")
              );
            }
          ),

          // profil
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              size: 48,
            ),
            title: const Text("profil"),
            subtitle: const Text("profil pengguna"),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/profil"
              );
            },
          ),
          const Divider(),

          // tentang
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 48,
            ),
            title: const Text("tentang"),
            subtitle: const Text("tentang aplikasi"),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/tentang"
              );
            },
          ),

          // ke luar
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 48,
            ),
            title: const Text("ke luar"),
            subtitle: const Text("ke luar dari aplikasi"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const KeLuar();
                }
              );
            },
          ),
        ],
      ),
    );
  }
}
