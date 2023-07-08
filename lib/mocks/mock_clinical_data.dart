import 'package:rehome/domain/models/patient/clinical_data.dart';

// Mocks zum Testen von ClinicalData spezifischen Objekten
// Alle hier implementierten Klassen sind zu finden in 'domain/models/patient/clinical_data.dart'
class ClinicalDataMock {
  // Paresis Sides
  static ParesisSide both = ParesisSide.both;
  static ParesisSide left = ParesisSide.left;
  static ParesisSide right = ParesisSide.right;

  // DateTimes
  static DateTime date1 = DateTime(2023, 3, 14, 16, 12, 44, 36);
  static DateTime date2 = DateTime(2023, 2, 27, 14, 4, 42, 2);
  static DateTime date3 = DateTime(2023, 4, 14, 5, 55, 11, 45);
  static DateTime date4 = DateTime(2023, 5, 21, 13, 13, 55, 14);
  static DateTime date5 = DateTime(2023, 7, 8, 22, 22, 22, 22);
  static DateTime date6 = DateTime(2023, 1, 2, 34, 56, 78, 99);

  // Clinical Test Objekte
  static const ClinicalTest fuglTest1 = FuglMeyerScale(1, 1, 2, 1, 2, "test1");
  static const ClinicalTest fuglTest2 =
      FuglMeyerScale(2, 3, 2, 3, 3, "Test am 3.4");
  static const ClinicalTest fuglTest3 =
      FuglMeyerScale(2, 0, 1, 2, 0, "Test vom 4.3");
  static const ClinicalTest fuglTest4 =
      FuglMeyerScale(1, 0, 0, 0, 1, "Starttest vom 12.2");
  static const ClinicalTest fuglTest5 =
      FuglMeyerScale(1, 2, 1, 0, 1, "Wochen Endtest");
  static const ClinicalTest broetzTest1 =
      BroetzScale("Test am 4.4", 1, 2, 1, 1);
  static const ClinicalTest broetzTest2 =
      BroetzScale("Starttest vom 1.1", 1, 3, 4, 1);
  static const ClinicalTest broetzTest3 =
      BroetzScale("Test vom 5.12", 1, 1, 0, 1);
  static const ClinicalTest broetzTest4 =
      BroetzScale("erster Test", 0, 0, 0, 1);
  static const ClinicalTest broetzTest5 =
      BroetzScale("dritter Test", 1, 4, 1, 2);

  // ClinicalTest Lists
  static List<ClinicalTest> tests1 = List.empty(growable: true)
    ..add(fuglTest1)
    ..add(fuglTest2)
    ..add(broetzTest1);
  static List<ClinicalTest> tests2 = List.empty(growable: true)
    ..add(fuglTest2)
    ..add(fuglTest3)
    ..add(fuglTest1);
  static List<ClinicalTest> tests3 = List.empty(growable: true)
    ..add(broetzTest1)
    ..add(broetzTest2)
    ..add(broetzTest3)
    ..add(fuglTest2);
  static List<ClinicalTest> tests4 = List.empty(growable: true)
    ..add(fuglTest3)
    ..add(broetzTest1);
  static List<ClinicalTest> tests5 = List.empty(growable: true)..add(fuglTest4);
  static List<ClinicalTest> tests6 = List.empty(growable: true)
    ..add(fuglTest4)
    ..add(fuglTest5)
    ..add(broetzTest2)
    ..add(broetzTest1)
    ..add(broetzTest3)
    ..add(broetzTest5);

  // Clinical Data Objekte
  static ClinicalData clinicalData1 = ClinicalData(left, date1, tests1);
  static ClinicalData clinicalData2 = ClinicalData(left, date2, tests2);
  static ClinicalData clinicalData3 = ClinicalData(both, date3, tests3);
  static ClinicalData clinicalData4 = ClinicalData(both, date2, tests4);
  static ClinicalData clinicalData5 = ClinicalData(both, date4, tests2);
  static ClinicalData clinicalData6 = ClinicalData(right, date1, tests5);
  static ClinicalData clinicalData7 = ClinicalData(right, date4, tests6);
  static ClinicalData clinicalData8 = ClinicalData(right, date5, tests2);
  static ClinicalData clinicalData9 = ClinicalData(right, date6, tests3);
}
