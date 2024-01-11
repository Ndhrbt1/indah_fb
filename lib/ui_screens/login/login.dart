import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indah_fb/ui_screens/admin/admin_list.dart';
import 'package:indah_fb/ui_screens/customer/customer_list.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  html.window.open('https://github.com/Ndhrbt1/indah_fb', 'new tab');
                },
                child: const Text(
                  "Go to Github",
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  // await FirebaseAuth.instance.signInAnonymously();

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminList()),
                  );
                },
                child: const Text(
                  "Go to Admin Page",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signInAnonymously();

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomerList()),
                  );
                },
                child: const Text(
                  "Login Anonymous",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final GoogleAuthProvider provider =
                      GoogleAuthProvider().setCustomParameters({'prompt': 'select_account'});
                  await FirebaseAuth.instance.signInWithPopup(provider);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomerList()),
                  );
                },
                child: const Text(
                  "Login by Google",
                ),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: snapshot.data == null
              //       ? null
              //       : () async {
              //           await FirebaseAuth.instance.signOut();
              //         },
              //   child: const Text(
              //     "Logout",
              //   ),
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: snapshot.data == null
              //       ? null
              //       : () async {
              //           await FirebaseAuth.instance.currentUser!.delete();
              //         },
              //   child: const Text(
              //     "Delete Account",
              //   ),
              // ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
