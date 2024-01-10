import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:indah_fb/app/app.dart';
import 'package:indah_fb/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
