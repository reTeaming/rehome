import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserAuth {
  // Authentifizierung von Endbenutzern durch Backend
  // User wird anhand vom gegebenem Nutzernamen und Passwort authentifiziert
  Future<bool> authUser(String username, String password) async {
    final user = ParseUser(username, password, null);

    var respone = await user.login();

    return respone.success;
  }

  // Registrierung von Endbenutzern (NUR für Entwicklungszwecke)
  // Benutzer wird mit gegebenem Nutzernamen und Passwort einer generierten Email-Adresse (anhand von Nutzernamen) erstellt
  Future<bool> createUser(String username, String password) async {
    final usernameTrimmed = username.trim();
    final passwordTrimmed = password.trim();
    final emailTrimmed = "$usernameTrimmed@gmail.com".trim();

    final user =
        ParseUser.createUser(usernameTrimmed, passwordTrimmed, emailTrimmed);

    var response = await user.signUp();

    return response.success;
  }
}
