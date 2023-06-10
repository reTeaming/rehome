import 'dart:async';
import 'package:ReHome/data/backend_login.dart';

// Mögliche Authentifizierungszustände
enum AuthStatus { unknown, authenticated, unauthenticated }

// AutheRepository ist die Schnittstelle zwischen Front und Backend
// für alles was mit Authentifizierung zu tun hat
class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    // Mock für backend
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    // backend Anbindung wird aufgerufen und user wird authentifiziert
    var success = await UserAuth().authUser(username, password);
    // Bei erfolgreicher Authentifizierung wird AuthStatus geändert
    if (success) {
      _controller.add(AuthStatus.authenticated);
    } else {
      _controller.add(AuthStatus.unauthenticated);
    }
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
