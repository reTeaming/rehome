import 'package:ReHome/business_logic/auth/auth_bloc.dart';
import 'package:ReHome/domain/repositories/auth_repository.dart';
import 'package:ReHome/domain/repositories/user_repository.dart';
import 'package:ReHome/presentation/home.dart';
import 'package:ReHome/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/splash.dart';

// Gerüst um alle Repositorys, Grundlegende-Blocs, etc. zu initialisieren
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    // alle 'Streams' von 'AuthRepository' werden geschlossen
    _authRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Reppositories werden dem Rest des Widget-Baums zugünglich gemacht
    return RepositoryProvider.value(
      value: _authRepository,
      // Blocs werden dem Rest des Widget Baumes zugägnlich gemacht
      child: BlocProvider(
        create: (_) => AuthBloc(
          authRepository: _authRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

// 'AppView' stellt das Theme sowie den Navigator
class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        // rounting basierend auf dem Authentifizierungszustand
        // 'AuthBloc' stellt die zugrundelegende Logik
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
              case AuthStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      // initial wird auf die SplashPage geleitet
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}