// Galle win 7 SHA1:  3B:2E:4A:A3:5B:79:8B:3A:52:75:F5:6C:3A:29:0B:4C:18:0E:55:1A

// Aspire 5 win 11 SHA1:   EF:31:12:EF:1F:D3:38:8C:CE:0C:CC:F2:1B:56:83:B7:4F:7B:FE:E0

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppModule());
}
