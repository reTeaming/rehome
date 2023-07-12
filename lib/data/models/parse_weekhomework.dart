import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyWeekHomework = "WeekHomework";

// Field keys
const String keyWeek = "week";
const String keyYear = "year";

// Relation keys
const String keyExerciseBlocks = "exercises";

class ParseWeekHomework extends ParseObject implements ParseCloneable {
  ParseWeekHomework() : super(keyWeekHomework);
  ParseWeekHomework.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParseWeekHomework.clone()..fromJson(map);

  // Fields
  int? get week => get<int>(keyWeek);
  set week(int? week) => set<int?>(keyWeek, week);

  int? get year => get<int>(keyYear);
  set year(int? year) => set<int?>(keyYear, year);

  // Relations
  ParseRelation? get exerciseBlocks => get<ParseRelation>(keyExerciseBlocks);
  void addExerciseBlock(ParseObject exerciseBlock) =>
      addExerciseBlocks([exerciseBlock]);
  void addExerciseBlocks(List<ParseObject> exerciseBlocks) =>
      super.addRelation(keyExerciseBlocks, exerciseBlocks);
  void removeGoal(ParseObject exerciseBlock) => removeGoals([exerciseBlock]);
  void removeGoals(List<ParseObject> exerciseBlocks) =>
      super.removeRelation(keyExerciseBlocks, exerciseBlocks);
}
