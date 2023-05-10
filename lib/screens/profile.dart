/// The "Profile" Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_app/widgets.dart';
import 'package:basic_app/db/model.dart';

final profileScreen = ProfileScreen("Profil");

/// # The "Profil" screen
class ProfileScreen extends StatelessWidget implements DefaultScreen {
  final String title;
  ProfileScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildImpulsAppBar(context, title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<UserModel>(builder: (context, userModel, child) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Nickname:${userModel.userAccountData.nickname}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Signed up: ${userModel.userAccountData.signedUpDate}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    ' Favourite Sports: ${userModel.userAccountData.favouriteSports}'),
              ),
            ]);
          }),
        ],
      ),
    );
  }
}
