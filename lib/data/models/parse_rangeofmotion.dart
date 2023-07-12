import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyRangeOfMotion = "RangeOfMotion";

// Field keys
const String keyValue = "value";
const String keyJoint = "joint";

class ParseRangeOfMotion extends ParseObject implements ParseCloneable {
  ParseRangeOfMotion() : super(keyRangeOfMotion);
  ParseRangeOfMotion.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParseRangeOfMotion.clone()..fromJson(map);

  // Fields
  // non-nullable, because field is required in Database
  double get value => get<double>(keyValue)!;
  set value(double value) => set<double>(keyValue, value);

  // non-nullable, because field is required in Database
  String get joint => get<String>(keyJoint)!;
  set joint(String joint) => set<String>(keyJoint, joint);
}
