library auth_bloc;

import 'dart:async';
import 'package:reHome/domain/models/user/name.dart';
import 'package:reHome/domain/models/user/user.dart';
import 'package:reHome/domain/repositories/auth_repository.dart';
import 'package:reHome/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/auth/username.dart';
import '../../domain/models/user/institution.dart';
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
    on<SaveUserInformation>(_onSaveUserInformation);

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

  void _onSaveUserInformation(
    SaveUserInformation event,
    Emitter<AuthState> emit,
  ) {
    var value1 = Name(event.name.length > 0 ? event.name : event.user.name.name,
        event.surname.length > 0 ? event.surname : event.user.name.surname);
    var value2 = Username.dirty(
        event.userName.length > 0 ? event.userName : event.user.username.value);
    var value3 = Institution(
      event.user.institution.organisationId,
      event.institut.length > 0 ? event.institut : event.user.institution.name,
      event.user.institution.departement,
    );
    // Synchrone Übertragung von Daten zum Backend.
    _userRepository.updateName(value1);
    _userRepository.updateUsername(value2);
    _userRepository.updateInstitution(value3);

    // Geänderte Werte.
    _userRepository.updateDate(value1, value2, value3);
    // Aktualisierung der UI mit Status.
    return emit(AuthState.authenticated(_userRepository.user!));
  }
}
