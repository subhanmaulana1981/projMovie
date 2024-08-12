
import 'dart:io';
import 'package:flutter/material.dart';

class KeLuar extends StatelessWidget {
  const KeLuar({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.question_mark,
        size: 48,
      ),
      iconPadding: const EdgeInsets.all(8.0),
      iconColor: Colors.amber,
      title: const Text("konfirmasi"),
      titlePadding: const EdgeInsets.all(8.0),
      content: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Text>[
          Text("Anda akan ke luar dari aplikasi!"),
          Text("yakin yang Anda lakukan?")
        ],
      ),
      contentPadding: const EdgeInsets.all(8.0),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("tidak")
        ),
        TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text("ya")
        )
      ],
      actionsPadding: const EdgeInsets.all(8.0),
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
