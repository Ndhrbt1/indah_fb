import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              html.window.open('https://github.com/Ndhrbt1/indah_fb', 'new tab');
            },
            child: const Text(
              "github",
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
