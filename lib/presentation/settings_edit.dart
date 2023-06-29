import 'package:ReHome/domain/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/auth/auth_bloc.dart';

class SettingsEditPage extends StatefulWidget {
  const SettingsEditPage({super.key});

  @override
  State<SettingsEditPage> createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController institutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final user = context.select((AuthBloc bloc) => bloc.state.user);

      return Scaffold(
          body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const Center(child: Text('Edit Profil')),
            const SizedBox(height: 20),
            buildTextField('name', user.name.name, nameController),
            const SizedBox(height: 10),
            buildTextField('surname', user.name.surname, surnameController),
            const SizedBox(height: 10),
            buildTextField('Username', user.username.value, usernameController),
            const SizedBox(height: 10),
            buildTextField(
                'Institution', user.institution.name, institutionController),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button, um zur vorherigen Seite zurückzukehren.
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                const SizedBox(width: 30),

                ElevatedButton(
                    onPressed: () {
                      // Extrahiert den Text im Eingabefeld, um die geänderten Informationen zu speichern
                      context.read<AuthBloc>().add(SaveUserInformation(
                          nameController.text.toString().trim(),
                          surnameController.text.toString().trim(),
                          usernameController.text.toString().trim(),
                          institutionController.text.toString().trim(),
                          user));
                      Navigator.pop(context);
                    },
                    child: const Text('Save'))
              ],
            )
          ],
        ),
      ));
    });
  }

  TextField buildTextField(
      String labeltext, String placeholder, TextEditingController _controller) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        labelText: labeltext,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
      ),
    );
  }
}
