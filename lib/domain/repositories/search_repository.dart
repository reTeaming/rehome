import 'package:ReHome/presentation/searchwidget.dart';


// Schnittstelle zum Backend für die Abfrage von Patientendaten.
class SearchRepository {
  List? _dummyList; 

  Future<List?> getList() async {
    if (_dummyList != null) return _dummyList;
    // Mock für den Patienten
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _dummyList = dummyList);
  }
}


      // () => _dummyList = const Patient(
      //     Name.empty,
      //     Sex.MALE,
      //     ConstDateTime(20),
      //     ConstDateTime(2000),
      //     ExerciseDefaultData.defaultexercisedata,
      //     ClinicalData.mockdata,
      //     Goals([]),
      //     Homework.mockhomework,
      //     PatientStatus.ACTIVE),
