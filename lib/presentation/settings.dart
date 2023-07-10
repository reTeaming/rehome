import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/auth/auth_bloc.dart';
import 'settings_edit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      final user = state.user;
      return Center(
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
          SettingsTextField(
            "Name",
            "${user.name.name} ${user.name.surname}",
            const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // Benutzername anzeigen
          SettingsTextField("Username", user.username.value,
              const Icon(Icons.mail, color: Colors.black)),

          const SizedBox(
            height: 10,
          ),

          // Institution anzeigen.
          SettingsTextField("Institution", user.institution.name,
              const Icon(Icons.account_balance, color: Colors.black)),
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
                // routing zur LoginPage erfolgt über den Bloc
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
              },
              child: const Text("Logout")),
        ]),
      );
    });
  }
}

class SettingsTextField extends StatelessWidget {
  final String text;
  final String prefix;
  final Icon icon;

  const SettingsTextField(
    this.prefix,
    this.text,
    this.icon, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              builder: (BuildContext context) => const SettingsEditPage()));
        },
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              '$prefix: $text',
              style: const TextStyle(fontSize: 15, color: Colors.black),
            )),
            const Icon(
              Icons.edit,
            )
          ],
        ),
      ),
    );
  }
}
