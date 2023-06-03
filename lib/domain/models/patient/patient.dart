import 'package:ReHome/domain/models/patient/clinicalData.dart';
import 'package:ReHome/domain/models/patient/exerciseDefaultData.dart';
import 'package:ReHome/domain/models/patient/goals.dart';
import 'package:ReHome/domain/models/patient/sex.dart';
import 'package:ReHome/domain/models/user/name.dart';
import 'package:ReHome/domain/models/user/homework.dart';

class Patient {
  Name name;
  Sex sex;
  DateTime birthDate;
  List<ExerciseDefaultData> exerciseDefaults;
  ClinicalData clinicalData;
  Goals goals;
  Homework homework;

  Patient(this.name, this.sex, this.birthDate, this.exerciseDefaults,
      this.clinicalData, this.goals, this.homework);
}
