
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Memuat extends StatelessWidget {
  const Memuat({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    ColorScheme colorScheme = themeData.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpinKitCubeGrid(
            color: colorScheme.onSurfaceVariant,
            size: 48.0,
          ),
          const SizedBox(
            height: 8.0,
          ),

          Text(
            "memuat, harap tunggu",
            style: themeData.textTheme.labelLarge,
          )
        ],
      ),
    );
  }
}
