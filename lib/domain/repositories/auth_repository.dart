import 'dart:async';

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
    // Mock für backend
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
