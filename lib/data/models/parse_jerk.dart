import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyJerk = "Jerk";

// Field keys
const String keyValue = "value";

class ParseJerk extends ParseObject implements ParseCloneable {
  ParseJerk() : super(keyJerk);
  ParseJerk.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParseJerk.clone()..fromJson(map);

  // Fields

  // non-nullable, because field is required in Database
  double get value => get<double>(keyValue)!;
  set value(double value) => set<double>(keyValue, value);
}
