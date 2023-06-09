import 'package:flutter/material.dart';
import 'package:rehome/app.dart';
import 'package:rehome/data/backend_init.dart';
import 'package:rehome/domain/repositories/secrets_repository.dart';

void main() async {
  // initalize backend
  var secrets = await SecretsRepositroy.loadFromEnv();
  if (secrets == null) {
    throw "Environment Variables for SecrestsRepository not found!";
  }

  // aufruf der parser initialisierung für backend
  WidgetsFlutterBinding.ensureInitialized();
  await InitializerBackend()
      .initParser(secrets.clientKey, secrets.applicationId);

  // startet die Flutter App
  runApp(App(secrets));
}
