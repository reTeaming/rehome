import 'package:const_date_time/const_date_time.dart';
import 'package:rehome/domain/models/patient/models.dart';

import '../models/patient/goals.dart';
import '../models/patient/homework.dart';
import '../models/user/name.dart';

// Schnittstelle zum Backend für die Abfrage von Patientendaten.
class PatientRepository {
  Patient? _patient;

  Future<Patient?> getPatient() async {
    if (_patient != null) return _patient;
    // Mock für den Patienten
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _patient = const Patient(
          Name.empty,
          Sex.male,
          ConstDateTime(20),
          ConstDateTime(2000),
          ExerciseDefaultData.defaultexercisedata,
          ClinicalData.mockdata,
          Goals([]),
          Homework.mockhomework,
          PatientStatus.active),
    );
  }
}
