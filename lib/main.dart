import 'package:ReHome/app.dart';
import 'package:ReHome/data/backend_init.dart';
import 'package:flutter/material.dart';

void main() async {
  // aufruf der parser initialisierung für backend
  WidgetsFlutterBinding.ensureInitialized();
  InitializerBackend().initParser();
  // startet die Flutter App
  runApp(const App());
}
