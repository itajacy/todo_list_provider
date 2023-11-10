//  SHA1:  3B:2E:4A:A3:5B:79:8B:3A:52:75:F5:6C:3A:29:0B:4C:18:0E:55:1A

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppModule());
}
