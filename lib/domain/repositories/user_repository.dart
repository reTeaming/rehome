import 'dart:async';
import 'package:ReHome/domain/models/user.dart';

import 'package:uuid/uuid.dart';

// Schnittstelle zum Backend für die Abfrage von NutzerDaten.
// Die Authentifizierung (login/logout) wird vollständig vom 'AuthRepository'
// übernommen
class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    // Mock für den Nutzer
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4()),
    );
  }
}
