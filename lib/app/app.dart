import 'package:flutter/material.dart';

// import 'package:indah_fb/ui_screens/home/home.dart';
import 'package:indah_fb/ui_screens/login/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.dark(),
      // home: const AdminInput(),
      // home: const AdminList(),
      // home: const CustomerList(),
      home: const Login(),
      // home: const Home(),
    );
  }
}
