import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecretsRepositroy {
  final String applicationId;
  final String clientKey;

  SecretsRepositroy._(this.applicationId, this.clientKey);

  static Future<SecretsRepositroy?> loadFromEnv() async {
    await dotenv.load(fileName: ".env", mergeWith: Platform.environment);
    final appId = dotenv.env["APPLICATION_ID"];
    final clientKey = dotenv.env["CLIENT_KEY"];

    if (appId == null || clientKey == null) {
      return null;
    }

    return SecretsRepositroy._(appId, clientKey);
  }
}
