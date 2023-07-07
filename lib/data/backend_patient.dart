import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rehome/data/models/parse_patient.dart';

class PatientBackend {
  Future<ParsePatient?> getPatientById(String id) async {
    final ParseResponse response = await ParsePatient().getObject(id);
    if (response.success == true) {
      return response.result;
    }
    return null;
  }
}
