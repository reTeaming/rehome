import 'package:ReHome/app.dart';
import 'package:ReHome/data/backend_init.dart';
import 'package:ReHome/domain/repositories/secrets_repository.dart';
import 'package:flutter/material.dart';

void main() async {
  // initalize backend
  var secrets = await SecretsRepositroy.loadFromEnv();
  if (secrets == null) {
    throw "Environment Variables for SecrestsRepository not found!";
  }

  // aufruf der parser initialisierung für backend
  WidgetsFlutterBinding.ensureInitialized();
  InitializerBackend().initParser(secrets.clientKey, secrets.applicationId);
  // startet die Flutter App
  runApp(App(secrets));
}
