import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyExercise = "Exercise";

// Pointer keys
const String keyDefaultExercise = "exerciseType";

// Relation keys
const String keyParameterSet = "parameters";

class ParseExercise extends ParseObject implements ParseCloneable {
  ParseExercise() : super(keyExercise);
  ParseExercise.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParseExercise.clone()..fromJson(map);

  // Pointer
  ParseObject? get defaultExercise => get<ParseObject>(keyDefaultExercise);
  set defaultExercise(ParseObject? defaultExercise) =>
      set<ParseObject?>(keyDefaultExercise, defaultExercise);

  // Relations
  ParseRelation? get parameterSets => get<ParseRelation>(keyParameterSet);
  void addParameterSet(ParseObject parameterSet) =>
      addParameterSets([parameterSet]);
  void addParameterSets(List<ParseObject> parameterSets) =>
      super.addRelation(keyParameterSet, parameterSets);
  void removeParameterSet(ParseObject parameterSet) =>
      removeParameterSets([parameterSet]);
  void removeParameterSets(List<ParseObject> parameterSets) =>
      super.removeRelation(keyParameterSet, parameterSets);
}
