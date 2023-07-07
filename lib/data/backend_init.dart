import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Initialisierung der Backend Anbindung
class InitializerBackend {
  // Parser wird mit keys (aus back4App) initialisiert
  Future<void> initParser(String clientKey, String applicationId) async {
    const keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(applicationId, keyParseServerUrl,
        clientKey: clientKey, autoSendSessionId: true);
  }
}
