import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyGoal = "Goal";

// Field keys
const String keyStatus = "status";
const String keyDescription = "description";

class ParseGoal extends ParseObject implements ParseCloneable {
  ParseGoal() : super(keyGoal);

  // Non nullable - because field is required in Database
  String get status => get<String>(keyStatus)!;
  set status(String status) => set(keyStatus, status);

  // Non nullable - because field is required in Database
  String get description => get<String>(keyDescription)!;
  set description(String description) => set(keyDescription, description);
}
