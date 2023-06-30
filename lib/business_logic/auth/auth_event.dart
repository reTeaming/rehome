part of 'auth_bloc.dart';

// Events für den AuthBloc
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.status, this.user);

  final AuthStatus status;
  final User? user;
}

final class AuthLogoutRequested extends AuthEvent {}
