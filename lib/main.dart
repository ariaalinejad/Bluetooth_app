import 'package:flutter/material.dart';
import 'blue.dart';



Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

   runApp(const MaterialApp(
      home: Home(),
   ));
}