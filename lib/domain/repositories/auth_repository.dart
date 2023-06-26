import 'dart:async';
import 'package:ReHome/data/backend_login.dart';
import 'package:ReHome/domain/models/user/user.dart';

// Mögliche Authentifizierungszustände
enum AuthStatus { unknown, authenticated, unauthenticated }

// AutheRepository ist die Schnittstelle zwischen Front und Backend
// für alles was mit Authentifizierung zu tun hat
class AuthRepository {
  // stream gibt AuthStatus und User zurück. Der User ist nur bei AuthStatus.authenticated
  // vorhanden und ansonsten immer null. Dies ist notwendig, damit der AuthBloc dem
  // UserRepository einen User übergeben kann
  final _controller = StreamController<(AuthStatus, User?)>();

  Stream<(AuthStatus, User?)> get status async* {
    yield (AuthStatus.unauthenticated, null);
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    // backend Anbindung wird aufgerufen und user wird authentifiziert
    User? user = await UserAuth().authUser(username, password);
    // Bei erfolgreicher Authentifizierung wird User und AuthStatus dem AuthBloc per Stream gemeldet
    if (user != null) {
      _controller.add((AuthStatus.authenticated, user));
    } else {
      _controller.add((AuthStatus.unauthenticated, null));
    }
  }

  void logOut() {
    _controller.add((AuthStatus.unauthenticated, null));
  }

  void dispose() => _controller.close();
}
