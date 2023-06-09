import 'package:rehome/domain/models/auth/username.dart';
import 'package:rehome/domain/models/user/institution.dart';
import 'package:rehome/domain/models/user/name.dart';
import 'package:rehome/domain/models/user/user.dart';
import 'package:rehome/data/backend_user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Schnittstelle zum Backend für die Abfrage von NutzerDaten.
// Die Authentifizierung (login/logout) wird vollständig vom 'AuthRepository'
// übernommen
class UserRepository {
  User? _user;

  // wird vom AuthBloc aufgerufen, um den von AuthRepository erhaltenen User zu übergeben
  void setUser(User user) {
    _user = user;
  }

  // aktualisiert Namen des Benutzers und ruft Funktion für Backend Änderung auf
  Future<void> updateName(Name name) async {
    if (_user == null) return;
    // Rufe Backend Änderung auf
    ParseResponse response =
        await UserBackend().updateBackendName(_user!.id, name);
    // falls Backend Änderung erfolgreich war, aktualisiere auch Nutzer in Repository
    if (response.success) {
      _user = User(_user!.id, name, _user!.username, _user!.institution);
    }
  }

  // aktualisiert Namen des Benutzers und ruft Funktion für Backend Änderung auf
  Future<void> updateUsername(Username username) async {
    if (_user == null) return;
    // Rufe Backend Änderung auf
    ParseResponse response =
        await UserBackend().updateBackendUsername(_user!.id, username);
    // falls Backend Änderung erfolgreich war, aktualisiere auch Nutzer in Repository
    if (response.success) {
      _user = User(_user!.id, _user!.name, username, _user!.institution);
    }
  }

  // aktualisiert Namen des Benutzers und ruft Funktion für Backend Änderung auf
  Future<void> updateInstitution(Institution institution) async {
    if (_user == null) return;
    // Rufe Backend Änderung auf
    ParseResponse response =
        await UserBackend().updateBackendInstitution(_user!.id, institution);
    // falls Backend Änderung erfolgreich war, aktualisiere auch Nutzer in Repository
    if (response.success) {
      _user = User(_user!.id, _user!.name, _user!.username, institution);
    }
  }

  // Abrufen der geänderten Werten
  void updateDate(Name name, Username username, Institution institution) {}

  User? get user => _user;
}
