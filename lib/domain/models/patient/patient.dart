import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rehome/data/models/parse_clinical_data.dart';
import 'package:rehome/data/models/parse_goal.dart';
import 'package:rehome/domain/models/patient/clinical_data.dart';
import 'package:rehome/data/models/parse_patient.dart';
import 'package:rehome/domain/models/patient/exercise_default_data.dart';
import 'package:rehome/domain/models/patient/goals.dart';
import 'package:rehome/domain/models/user/name.dart';
import 'package:rehome/domain/models/patient/homework.dart';
import 'package:equatable/equatable.dart';
import 'package:const_date_time/const_date_time.dart';

class Patient extends Equatable {
  static Future<Patient?> fromParse(ParsePatient patient) async {
    return await _buildPatientFromParse(patient);
  }

  const Patient(
      {required this.name,
      required this.sex,
      required this.birthDate,
      required this.therapyStart,
      required this.exerciseDefaults,
      required this.clinicalData,
      required this.goals,
      required this.homework,
      required this.status});

  final Name name;
  final Sex sex;
  final DateTime birthDate;
  final DateTime? therapyStart;
  final ExerciseDefaultData exerciseDefaults;
  final ClinicalData clinicalData;
  final Goals goals;
  final Homework homework;
  final PatientStatus status;

  static Future<Patient?> _buildPatientFromParse(ParsePatient patient) async {
    final Name name = Name(patient.name, patient.surname);
    final ClinicalData? clinicalData = patient.clinicalData != null
        ? ((await ParseClinicalData()
                    .getObject(patient.clinicalData!.objectId!))
                .result as ParseClinicalData)
            .toClinicalData()
        : null;
    final Homework? homework = await _getHomework(patient);
    final Goals goals = await _getGoals(patient);
    final ExerciseDefaultData? exerciseDefaults =
        await _getExerciseDefaults(patient);
    // geben null zurück, wenn keine ClinicalData vorhanden sind.
    if (clinicalData == null || homework == null || exerciseDefaults == null) {
      return null;
    }

    return Patient(
      name: name,
      sex: patient.sex.toSex(),
      birthDate: patient.birthdate,
      therapyStart: patient.therapyStart,
      status: patient.status.toPatientStatus(),
      clinicalData: clinicalData,
      homework: homework,
      goals: goals,
      exerciseDefaults: exerciseDefaults,
    );
  }

  static Future<Homework?> _getHomework(ParsePatient patient) async {
    if (patient.homework == null) return null;
    // ignore: unused_local_variable
    final List<ParseObject> homework =
        await patient.homework!.getQuery().find();

    // TODO: Implement

    return Homework.mockhomework;
  }

  static Future<Goals> _getGoals(ParsePatient patient) async {
    if (patient.goals == null) {
      return Goals(List.empty());
    }
    final List<ParseObject> parseGoals = await patient.goals!.getQuery().find();

    final goals = parseGoals.map((e) {
      final ParseGoal goal = ParseGoal()..fromJson(e.toJson());
      return goal.toGoal();
    }).toList();
    return Goals(goals);
  }

  static Future<ExerciseDefaultData?> _getExerciseDefaults(
      ParsePatient patient) async {
    if (patient.execiseDefaultData == null) return null;

    // ignore: unused_local_variable
    final parseExercises = patient.execiseDefaultData!.getQuery().find();

    // TODO: implement
    return ExerciseDefaultData.defaultexercisedata;
  }

  @override
  List<Object> get props => [
        name,
        sex,
        birthDate,
        exerciseDefaults,
        clinicalData,
        goals,
        homework,
        status
      ];

  static Patient mock = const Patient(
      name: Name.empty,
      sex: Sex.male,
      birthDate: ConstDateTime(2000),
      therapyStart: ConstDateTime(2000),
      exerciseDefaults: ExerciseDefaultData.defaultexercisedata,
      clinicalData: ClinicalData.mockdata,
      goals: Goals([]),
      homework: Homework.mockhomework,
      status: PatientStatus.active);
}

enum PatientStatus { inactive, active, archived }

enum Sex { male, female, other, unspecified }

extension FromParse on String {
  Sex toSex() {
    switch (this) {
      case "male":
        return Sex.male;
      case "famale":
        return Sex.female;
      case "other":
        return Sex.other;
      default:
        return Sex.unspecified;
    }
  }

  PatientStatus toPatientStatus() {
    switch (this) {
      case "inactive":
        return PatientStatus.inactive;
      case "archived":
        return PatientStatus.archived;
      // alles andere wird als Activer Patient angesehen
      default:
        return PatientStatus.active;
    }
  }
}
