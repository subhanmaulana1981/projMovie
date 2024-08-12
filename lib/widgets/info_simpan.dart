
import 'package:flutter/material.dart';

class InfoSimpan extends StatelessWidget {
  const InfoSimpan({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.info,
        size: 48,
      ),
      iconPadding: const EdgeInsets.all(8.0),
      iconColor: Colors.green,
      title: const Text("informasi"),
      titlePadding: const EdgeInsets.all(8.0),
      content: const Text("berhasil diTambahkan"),
      contentPadding: const EdgeInsets.all(8.0),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("ok")
        )
      ],
      actionsPadding: const EdgeInsets.all(8.0),
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
