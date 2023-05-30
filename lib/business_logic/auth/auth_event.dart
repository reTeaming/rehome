import 'package:ReHome/domain/repositories/auth_repository.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.status);

  final AuthStatus status;
}

final class AuthLogoutRequested extends AuthEvent {}
