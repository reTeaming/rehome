import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyCocontraction = "Cocontraction";

// Field keys
const String keyExtensor1 = "extensor1";
const String keyExtensor2 = "extensor2";
const String keyExtensor3 = "extensor3";
const String keyFlexor1 = "flexor1";
const String keyFlexor2 = "flexor2";
const String keyFlexor3 = "flexor3";

class ParseCocontraction extends ParseObject implements ParseCloneable {
  ParseCocontraction() : super(keyCocontraction);
  ParseCocontraction.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ParseCocontraction.clone()..fromJson(map);

  // Fields
  // non-nullable, because field is required in Database
  double get extensor1 => get<double>(keyExtensor1)!;
  set extensor1(double extensor1) => set<double>(keyExtensor1, extensor1);

  // non-nullable, because field is required in Database
  double get extensor2 => get<double>(keyExtensor2)!;
  set extensor2(double extensor2) => set<double>(keyExtensor2, extensor2);

  // non-nullable, because field is required in Database
  double get extensor3 => get<double>(keyExtensor3)!;
  set extensor3(double extensor3) => set<double>(keyExtensor3, extensor3);

  // non-nullable, because field is required in Database
  double get flexor1 => get<double>(keyFlexor1)!;
  set flexor1(double flexor1) => set<double>(keyFlexor1, flexor1);

  // non-nullable, because field is required in Database
  double get flexor2 => get<double>(keyFlexor2)!;
  set flexor2(double flexor2) => set<double>(keyFlexor2, flexor2);

  // non-nullable, because field is required in Database
  double get flexor3 => get<double>(keyFlexor3)!;
  set flexor3(double flexor3) => set<double>(keyFlexor3, flexor3);
}
