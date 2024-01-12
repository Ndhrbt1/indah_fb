import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indah_fb/ui_screens/customer/customer_list.dart';

// import 'package:indah_fb/ui_screens/home/home.dart';
import 'package:indah_fb/ui_screens/login/login.dart';

// final subsciption = FirebaseAuth.instance.authStateChanges().listen((event) {
//   print(event);
//   if (event != null) {
//     var route = MaterialPageRoute(builder: (context) => const CustomerList());

//     WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pushReplacement(context, route));
//   }
// });

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.dark(),
      // theme: ThemeData.light(),
      // home: const AdminInput(),
      // home: const AdminList(),
      // home: const CustomerList(),
      // home: const Login(),
      // home: const Home(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const CustomerList();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
