import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:indah_fb/ui_screens/login/login.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indah-Fb'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text(
                "Go to Olshop",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                html.window.open('https://github.com/Ndhrbt1/indah_fb', 'new tab');
              },
              child: const Text(
                "Go to Github",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
