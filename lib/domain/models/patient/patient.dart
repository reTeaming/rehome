import 'package:ReHome/domain/models/patient/clinicalData.dart';
import 'package:ReHome/domain/models/patient/exerciseDefaultData.dart';
import 'package:ReHome/domain/models/patient/goals.dart';
import 'package:ReHome/domain/models/user/name.dart';
import 'package:ReHome/domain/models/patient/homework.dart';
import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  const Patient(
      this.name,
      this.sex,
      this.birthDate,
      this.therapyStart,
      this.exerciseDefaults,
      this.clinicalData,
      this.goals,
      this.homework,
      this.status);

  final Name name;
  final Sex sex;
  final DateTime birthDate;
  final DateTime therapyStart;
  final ExerciseDefaultData exerciseDefaults;
  final ClinicalData clinicalData;
  final Goals goals;
  final Homework homework;
  final PatientStatus status;

  @override
  List<Object> get props => [
        name,
        sex,
        birthDate,
        therapyStart,
        exerciseDefaults,
        clinicalData,
        goals,
        homework,
        status
      ];
}

enum PatientStatus { INACTIVE, ACTIVE, ARCHIVED }

enum Sex { MALE, FEMALE, OTHER, UNSPECIFIED }
