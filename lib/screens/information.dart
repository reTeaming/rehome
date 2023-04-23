/// The "Informationen" Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_app/widgets.dart';
import 'package:basic_app/db/model.dart';

final infoScreen = InformationScreen("Informationen");

/// # The "Informationen" screen
class InformationScreen extends StatelessWidget implements DefaultScreen {
  final String title;
  InformationScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildImpulsAppBar(context, title),
        body: Center(
            child: Consumer<UserModel>(builder: (context, userModel, child) {
          return Text(userModel.userAccountData.nickname);
        })));
  }
}
