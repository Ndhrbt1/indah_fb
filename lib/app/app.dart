import 'package:flutter/material.dart';
import 'package:indah_fb/ui_screens/admin/admin_detail.dart';
import 'package:indah_fb/ui_screens/admin/admin_input.dart';
import 'package:indah_fb/ui_screens/admin/admin_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.dark(),
      // home: const AdminInput(),
      home: const AdminList(),
      // home: const Login(),
      // home: const Home(),
    );
  }
}
