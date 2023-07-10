import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rehome/data/models/parse_patient.dart';

class PatientBackend {
  static Future<ParsePatient?> getPatientById(String id) async {
    final ParseResponse response = await ParsePatient().getObject(id);
    if (response.success == true) {
      return response.result;
    }
    return null;
  }

  static Future<List<ParsePatient>?> getAllPatients() async {
    final ParseResponse response = await ParsePatient().getAll();
    if (response.success == true) {
      // wenn response true ist ist auf results != null
      return response.results!.map((e) => e as ParsePatient).toList();
    }
    return null;
  }
}
