import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import "backend_keys.dart";

// Initialisierung der Backend Anbindung
class InitializerBackend {
  // Parser wird mit keys (aus back4App) initialisiert
  void initParser() async {
    const keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);
  }
}
