import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// Initialisierung der Backend Anbindung
class InitializerBackend {
  // Parser wird mit keys (aus back4App) initialisiert
  void initParser() async {
    const keyApplicationId = 'fF5STvuTrCohAreeYgdO0r1QIsHyTooszAhEwyQe';
    const keyClientKey = 'aJZGZx48ef4yeF0q8oFG3liiLXfY5yvXFRSkpl44';
    const keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);
  }
}
