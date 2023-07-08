import 'package:rehome/domain/models/patient/patient.dart';
import 'package:rehome/domain/models/patient/exercise_default_data.dart';
import 'package:rehome/domain/models/user/name.dart';
import 'package:rehome/mocks/mock_clinical_data.dart';
import 'package:rehome/mocks/mock_exercise.dart';
import 'package:rehome/mocks/mock_goals.dart';
import 'package:rehome/mocks/mock_homework.dart';

// Mocks zum Testen von Patient und ExerciseDefaultData Objekten
// Alle hier implementierten Klassen sind zu finden in:
// - 'domain/models/patient/patient.dart'
// - 'domain/models/patient/exercise_default_data.dart.dart'
class PatientMock {
  // Names
  static const Name name1 = Name("Annie", "Leonhart");
  static const Name name2 = Name("Erwin", "Schmidt");
  static const Name name3 = Name("Helga", "Haas");
  static const Name name4 = Name("Uwe", "Underberg");
  static const Name name5 = Name("Armin", "Arlert");
  static const Name name6 = Name("Reiner", "Braun");

  // Sex
  static const Sex female = Sex.female;
  static const Sex male = Sex.male;
  static const Sex other = Sex.other;
  static const Sex none = Sex.unspecified;

  // DateTime - BirthDate
  static DateTime bDay1 = DateTime(1969, 3, 22);
  static DateTime bDay2 = DateTime(1972, 10, 14);
  static DateTime bDay3 = DateTime(1943, 5, 5);
  static DateTime bDay4 = DateTime(1925, 9, 27);
  static DateTime bDay5 = DateTime(1980, 11, 3);
  static DateTime bDay6 = DateTime(1954, 8, 1);

  // DateTime - TherapyStart
  static DateTime therapyStart1 = DateTime(2022, 11, 11);
  static DateTime therapyStart2 = DateTime(2023, 2, 28);
  static DateTime therapyStart3 = DateTime(2023, 5, 30);
  static DateTime therapyStart4 = DateTime(2023, 3, 22);
  static DateTime therapyStart5 = DateTime(2022, 12, 21);
  static DateTime therapyStart6 = DateTime(2023, 4, 9);

  // Patien Stati
  static const PatientStatus active = PatientStatus.active;
  static const PatientStatus inactive = PatientStatus.inactive;
  static const PatientStatus archived = PatientStatus.archived;

  // Exercise Default Datas
  static ExerciseDefaultData defaultData1 =
      ExerciseDefaultData(69, ExerciseMock.parameterListShoulder);
  static ExerciseDefaultData defaultData2 =
      ExerciseDefaultData(420, ExerciseMock.parameterListEllbow);
  static ExerciseDefaultData defaultData3 =
      ExerciseDefaultData(222, ExerciseMock.parameterListWrist);
  static ExerciseDefaultData defaultData4 =
      ExerciseDefaultData(31, ExerciseMock.parameterListMix3);
  static ExerciseDefaultData defaultData5 =
      ExerciseDefaultData(9, ExerciseMock.parameterListMix2);
  static ExerciseDefaultData defaultData6 =
      ExerciseDefaultData(1, ExerciseMock.parameterListMix1);

  // Patients
  static Patient annieLeonhart = Patient(
      name1,
      female,
      bDay1,
      therapyStart1,
      defaultData1,
      ClinicalDataMock.clinicalData1,
      GoalsMock.goals1,
      HomeworkMock.homework1,
      inactive);
  static Patient erwinSchmidt = Patient(
      name2,
      male,
      bDay2,
      therapyStart2,
      defaultData2,
      ClinicalDataMock.clinicalData5,
      GoalsMock.goals2,
      HomeworkMock.homework2,
      active);
  static Patient helgaHaas = Patient(
      name3,
      female,
      bDay3,
      therapyStart3,
      defaultData3,
      ClinicalDataMock.clinicalData2,
      GoalsMock.goals3,
      HomeworkMock.homework3,
      active);
  static Patient uweUnderberg = Patient(
      name4,
      male,
      bDay4,
      therapyStart4,
      defaultData4,
      ClinicalDataMock.clinicalData7,
      GoalsMock.goals4,
      HomeworkMock.homework4,
      active);
  static Patient arminArlert = Patient(
      name5,
      other,
      bDay5,
      therapyStart5,
      defaultData5,
      ClinicalDataMock.clinicalData9,
      GoalsMock.goals5,
      HomeworkMock.homework1,
      active);
  static Patient reinerBraun = Patient(
      name6,
      male,
      bDay6,
      therapyStart6,
      defaultData6,
      ClinicalDataMock.clinicalData3,
      GoalsMock.goals6,
      HomeworkMock.homework5,
      archived);
}
