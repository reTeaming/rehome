import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

const String keyClinicalData = "ClinicalData";
const String keyParesisSide = "parsesisSide";
const String keyLastStroke = "lastStroke";

class ParseClinicalData extends ParseObject implements ParseCloneable {
  ParseClinicalData() : super(keyClinicalData);

  String get parsesisSide => get<String>(keyParesisSide)!;
  set paresisSide(String side) => set<String>(keyParesisSide, side);

  DateTime get lastStroke => get<DateTime>(keyLastStroke)!;
  set lastStroke(DateTime time) => set<DateTime>(keyLastStroke, time);
}
