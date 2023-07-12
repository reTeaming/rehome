import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyParameterSet = "ParameterSet";

// Field keys
const String keyName = "name";
const String keyAchievedAt = "achievedAt";
const String keyRepetition = "repetition";

// Pointer keys
const String keyRangeOfMotion = "rangeOfMotion";
const String keyCocontraction = "cocontraction";
const String keyJerk = "jerk";

class ParseParameterSet extends ParseObject implements ParseCloneable {
  ParseParameterSet() : super(keyParameterSet);
  ParseParameterSet.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParseParameterSet.clone()..fromJson(map);

  // Fields
  // non-nullable, because field is required in Database
  String get name => get<String>(keyName)!;
  set name(String name) => set<String>(keyName, name);

  // non-nullable, because field is required in Database
  int get repetition => get<int>(keyRepetition)!;
  set repetition(int repetition) => set<int>(keyRepetition, repetition);

  DateTime? get achievedAt => get<DateTime>(keyAchievedAt);
  set achievedAt(DateTime? achievedAt) =>
      set<DateTime?>(keyAchievedAt, achievedAt);

  // Pointer
  ParseObject? get jerk => get<ParseObject>(keyJerk);
  set jerk(ParseObject? jerk) => set<ParseObject?>(keyJerk, jerk);

  ParseObject? get cocontraction => get<ParseObject>(keyCocontraction);
  set cocontraction(ParseObject? cocontraction) =>
      set<ParseObject?>(keyCocontraction, cocontraction);

  ParseObject? get rangeOfMotion => get<ParseObject>(keyRangeOfMotion);
  set rangeOfMotion(ParseObject? rangeOfMotion) =>
      set<ParseObject?>(keyRangeOfMotion, rangeOfMotion);
}
