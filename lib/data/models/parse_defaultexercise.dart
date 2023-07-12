import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyDefaultExercise = "DefaultExercise";

// Field keys
const String keyName = "name";
const String keyId = "typeId";

class ParseDefaultExercise extends ParseObject implements ParseCloneable {
  ParseDefaultExercise() : super(keyDefaultExercise);
  ParseDefaultExercise.clone() : this();

  @override
  clone(Map<String, dynamic> map) =>
      ParseDefaultExercise.clone()..fromJson(map);

  // Fields
  // non-nullable, because field is required in Database
  String get name => get<String>(keyName)!;
  set name(String name) => set<String>(keyName, name);

  // non-nullable, because field is required in Database
  String get id => get<String>(keyId)!;
  set id(String id) => set<String>(keyId, id);
}
