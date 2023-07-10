import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyPatient = "Patient";

// Field keys
const String keyName = "name";
const String keySurname = "surname";
const String keyBirthdate = "birthdate";
const String keySex = "sex";
const String keyStatus = "status";
const String keyTherapyStart = "therapyStart";

// Pointer keys
const String keyClinicalData = "clinicalData";

// Relation keys
const String keyGoals = "goals";
const String keyHomework = "homework";
const String keyExerciseDefaultData = "exerciseDefaultData";

class ParsePatient extends ParseObject implements ParseCloneable {
  ParsePatient() : super(keyPatient);
  ParsePatient.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParsePatient.clone()..fromJson(map);

  // Fields

  // non-nullable, because field is required in Database
  String get name => get<String>(keyName)!;
  set name(String name) => set<String>(keyName, name);

  // non-nullable, because field is required in Database
  String get surname => get<String>(keySurname)!;
  set surname(String surname) => set<String>(keySurname, surname);

  // non-nullable, because field is required in Database
  DateTime get birthdate => get<DateTime>(keyBirthdate)!;
  set birthdate(DateTime date) => set<DateTime>(keyBirthdate, date);

  // non-nullable, because field is required in Database
  String get sex => get<String>(keySex)!;
  set sex(String sex) => set<String>(keySex, sex);

  // non-nullable, because field is required in Database
  String get status => get<String>(keyStatus)!;
  set status(String status) => set<String>(keyStatus, status);

  DateTime? get therapyStart => get<DateTime>(keyTherapyStart);
  set therapyStart(DateTime? date) => set<DateTime?>(keyTherapyStart, date);

  // Pointer
  ParseObject? get clinicalData => get<ParseObject>(keyClinicalData);
  set clinicalData(ParseObject? data) =>
      set<ParseObject?>(keyClinicalData, data);

  // Relations
  ParseRelation? get goals => get<ParseRelation>(keyGoals);
  void addGoal(ParseObject goal) => addGoals([goal]);
  void addGoals(List<ParseObject> goals) => super.addRelation(keyGoals, goals);
  void removeGoal(ParseObject goal) => removeGoals([goal]);
  void removeGoals(List<ParseObject> goals) =>
      super.removeRelation(keyGoals, goals);

  ParseRelation? get execiseDefaultData =>
      get<ParseRelation>(keyExerciseDefaultData);
  void addDefaultExercise(ParseObject goal) => addDefaultExercises([goal]);
  void addDefaultExercises(List<ParseObject> goals) =>
      super.addRelation(keyExerciseDefaultData, goals);
  void removeDefaultExercise(ParseObject goal) =>
      removeDefaultExercises([goal]);
  void removeDefaultExercises(List<ParseObject> goals) =>
      super.removeRelation(keyGoals, goals);

  ParseRelation? get homework => get<ParseRelation>(keyHomework);
  void addHomework(ParseObject homework) => addHomeworks([homework]);
  void addHomeworks(List<ParseObject> homeworks) =>
      super.addRelation(keyHomework, homeworks);
  void removeHomework(ParseObject homework) => removeHomeworks([homework]);
  void removeHomeworks(List<ParseObject> homeworks) =>
      super.removeRelation(keyHomework, homeworks);
}
