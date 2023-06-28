import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

const String keyPatient = "Patient";
const String keyName = "name";
const String keySurname = "surname";
const String keyBirthdate = "birthdate";
const String keySex = "sex";
const String keyStatus = "status";
const String keyTherapyStart = "therapyStart";

class ParsePatient extends ParseObject implements ParseCloneable {
  ParsePatient() : super(keyPatient);
  ParsePatient.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParsePatient.clone()..fromJson(map);

  String get name => get<String>(keyName)!;
  set name(String name) => set<String>(keyName, name);

  String get surname => get<String>(keySurname)!;
  set surname(String surname) => set<String>(keySurname, surname);

  DateTime get birthdate => get<DateTime>(keyBirthdate)!;
  set birthdate(DateTime date) => set<DateTime>(keyBirthdate, date);

  String get sex => get<String>(keySex)!;
  set sex(String sex) => set<String>(keySex, sex);

  String get status => get<String>(keyStatus)!;
  set status(String status) => set<String>(keyStatus, status);

  DateTime? get therapyStart => get<DateTime>(keyTherapyStart);
  set therapyStart(DateTime? date) => set<DateTime?>(keyTherapyStart, date);
}
