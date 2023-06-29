import 'package:ReHome/business_logic/auth/auth_bloc.dart';

import 'package:ReHome/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_edit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        const SizedBox(
          height: 50,
        ),

        const Icon(
          Icons.account_circle,
          size: 100,
        ),

        const Text(
          'Profildaten',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        const SizedBox(
          height: 30,
          width: 220,
          child: Divider(
            color: Colors.black,
          ),
        ),

        // Vor- und Nachnamen anzeigen.
        Builder(
          builder: (context) {
            final userName = context.select(
              (AuthBloc bloc) => bloc.state.user.name,
            );
            return SizedBox(
              height: 50,
              width: 400,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 239, 239, 239),
                ),
                // Weiterleitung zur Seite zum SettingsChangePage.
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SettingsEditPage()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      'Name: ${userName.name} ${userName.surname}',
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    )),
                    const Icon(
                      Icons.edit,
                    )
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(
          height: 10,
        ),

        // Benutzername anzeigen.
        Builder(
          builder: (context) {
            final userName = context.select(
              (AuthBloc bloc) => bloc.state.user.username.value,
            );
            return SizedBox(
              height: 50,
              width: 400,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 239, 239, 239),
                ),
                // Weiterleitung zur Seite zum SettingsChangePage.
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SettingsEditPage()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      'Username: $userName',
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    )),
                    const Icon(
                      Icons.edit,
                    )
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(
          height: 10,
        ),

        // Institution anzeigen.
        Builder(
          builder: (context) {
            final userIns = context.select(
              (AuthBloc bloc) => bloc.state.user.institution,
            );
            return SizedBox(
              height: 50,
              width: 400,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 239, 239, 239),
                ),
                // Weiterleitung zur Seite zum SettingsChangePage.
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SettingsEditPage()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_balance,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      'Institution: ${userIns.name}',
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    )),
                    const Icon(
                      Icons.edit,
                    )
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(
          height: 30,
        ),

        ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 20))),
            onPressed: () {
              var bloc = BlocProvider.of<AuthBloc>(context);
              bloc.add(AuthLogoutRequested());
              // LoginPage
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (_) => false);
            },
            child: const Text(
              "Logout",
            )),
      ]),
    ));
  }
}
