import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyExerciseBlock = "ExerciseBlock";

// Field keys
const String keyName = "name";
const String keyDay = "day";
const String keyStatus = "status";

// Relation keys
const String keyExercise = "exercise";

class ParseExerciseBlock extends ParseObject implements ParseCloneable {
  ParseExerciseBlock() : super(keyExerciseBlock);
  ParseExerciseBlock.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParseExerciseBlock.clone()..fromJson(map);

  // Fields
  // non-nullable, because field is required in Database
  String get name => get<String>(keyName)!;
  set name(String name) => set<String>(keyName, name);

  // non-nullable, because field is required in Database
  String get day => get<String>(keyDay)!;
  set day(String day) => set<String>(keyDay, day);

  // non-nullable, because field is required in Database
  String get status => get<String>(keyStatus)!;
  set status(String status) => set<String>(keyStatus, status);

  // Relations
  ParseRelation? get exercises => get<ParseRelation>(keyExercise);
  void addExercise(ParseObject exercise) => addExercises([exercise]);
  void addExercises(List<ParseObject> exercises) =>
      super.addRelation(keyExercise, exercises);
  void removeExercise(ParseObject exercise) => removeExercises([exercise]);
  void removeExercises(List<ParseObject> exercises) =>
      super.removeRelation(keyExercise, exercises);
}
