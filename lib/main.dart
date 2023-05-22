import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:basic_app/db/model.dart';
import 'package:basic_app/db/storage.dart';
import 'package:basic_app/theme.dart';
import 'package:basic_app/widgets.dart';

void main() async {
  // Initialize binding to engine layer of Flutter (necessary for file early
  // file operations during boot)
  WidgetsFlutterBinding.ensureInitialized();
  if (!await JsonStorage(USER_STORAGE_NAME).exists) {
    //TODO Random code, replace with correct code later
    await createUserModel("xxx123");
  }
  Future<UserModel> userModel = getUserModel();
  runApp(ReHomeApp(await userModel));
}

/**
 * The main Widgets 
 */

// added new comment

/// Representation of the root node of the Impuls App
class ReHomeApp extends StatefulWidget {
  final UserModel userModel;

  const ReHomeApp(this.userModel, {Key? key}) : super(key: key);
  @override
  _RehomeAppState createState() => _RehomeAppState();
}

class _RehomeAppState extends State<ReHomeApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: widget.userModel),
        ],
        child: MaterialApp(
          title: 'ReHome',
          initialRoute: '/',
          theme: impulsThemeData,
          onGenerateRoute: ImpRouter.generateRoute,
        ));
  }
}
