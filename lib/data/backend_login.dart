import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserAuth {
  // Authentifizierung von Endbenutzern durch Backend
  // User wird anhand vom gegebenem Nutzernamen und Passwort authentifiziert
  // Rückgabewert ist der nun eingeloggte Benutzer oder null
  Future<ParseUser?> authUser(String username, String password) async {
    final user = ParseUser(username.trim(), password, null);

    var response = await user.login();
    if (response.success) return user;
    return null;
  }

  // Registrierung von Endbenutzern (NUR für Entwicklungszwecke)
  // Benutzer wird mit gegebenem Nutzernamen und Passwort einer generierten Email-Adresse (anhand von Nutzernamen) erstellt
  Future<bool> createUser(String username, String password,
      [String? email]) async {
    final usernameTrimmed = username.trim();
    final passwordTrimmed = password.trim();
    final emailTrimmed =
        (email == null) ? "$usernameTrimmed@gmail.com".trim() : email.trim();

    final user =
        ParseUser.createUser(usernameTrimmed, passwordTrimmed, emailTrimmed);

    var response = await user.signUp();

    return response.success;
  }
}
