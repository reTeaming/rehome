library auth_bloc;

import 'dart:async';

import 'package:rehome/domain/repositories/auth_repository.dart';
import 'package:rehome/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:rehome/domain/models/user/user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    // registriere passende Handler
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.status.listen((streamEvent) =>
        add(AuthStatusChanged(streamEvent.$1, streamEvent.$2)));
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  late StreamSubscription<(AuthStatus, User?)> _authStatusSubscription;

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }

  // Handler für Authentifizierungsstatusänderungen
  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        if (event.user == null) return emit(const AuthState.unauthenticated());
        // aktualisiere User im UserRepository
        _userRepository.setUser(event.user!);
        return emit(AuthState.authenticated(event.user!));
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  // Handler für Logount Event
  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logOut();
  }
}
