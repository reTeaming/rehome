import 'package:rehome/data/backend_patient.dart';
import 'package:rehome/data/models/parse_patient.dart';
import 'package:rehome/domain/models/patient/models.dart';

class PatientRepository {
  Future<Patient?> getPatientById(String id) async {
    final ParsePatient? parsePatient = await PatientBackend.getPatientById(id);
    if (parsePatient == null) return null;

    final Patient? patient = await Patient.fromParse(parsePatient);

    return patient;
  }

  Future<List<Patient>> getPatients() async {
    final List<ParsePatient>? parsePatients =
        await PatientBackend.getAllPatients();
    if (parsePatients == null) return List.empty();

    final patients = await Future.wait(
        parsePatients.map((patient) async => await Patient.fromParse(patient)));
    patients.removeWhere((e) => e == null);

    return patients.map((e) => e!).toList();
  }

  Future<void> updatePatient(Patient patient) async {
    // TODO: implement
  }

  Future<void> deletePatient(Patient patient) async {
    // TODO: implement
  }

  // TODO: Change void return to Patient
  Future<void> addPatient(Patient patient) async {
    // TODO: implement
  }
}
