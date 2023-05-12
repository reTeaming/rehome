/// The "User Information" Screen 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_app/widgets.dart';
import 'package:basic_app/db/model.dart';


final userInfoScreen = UserInformationScreen("Persönliche Daten");

class UserInformationScreen extends StatelessWidget implements DefaultScreen {
  final String title;
  UserInformationScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildImpulsAppBar(context, title),
        body: Center(
            child: Consumer<UserModel>(builder: (context, userModel, child) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Padding( 
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Username:   ${userModel.userAccountData.nickname}"),
                ),            
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("Sign-Up Date:   ${userModel.userAccountData.signedUpDate.toString()}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Favourite Sports: ${userModel.userAccountData.favouriteSports.toString()}"),
                ),

                

              ]

          ));
          
          
            
        })));
  }
}
