part of 'auth_bloc.dart';

// Events für den AuthBloc
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.status);

  final AuthStatus status;
}

final class AuthLogoutRequested extends AuthEvent {}
