import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Table identifier key
const String keyHomework = "Homework";

// Field key
const String keyRepeatedSince = "repeatedSince";

// Pointer key
const String keyRepeatedHomework = "repeatedHomework";

// Relation key
const String keyWeekHomeworks = "weekHomeworks";

class ParseHomework extends ParseObject implements ParseCloneable {
  ParseHomework() : super(keyHomework);
  ParseHomework.clone() : this();

  String? get repeatedSince => get<String>(keyRepeatedSince)!;
  set repeatedSince(String? repeatedSince) =>
      set<String?>(keyRepeatedSince, repeatedSince);

  // Pointer
  ParseObject? get repeatedHomework => get<ParseObject>(keyRepeatedHomework);
  set repeatedHomework(ParseObject? parseHomework) =>
      set<ParseObject?>(keyRepeatedHomework, parseHomework);

  // Relations
  ParseRelation? get weekHomeworks => get<ParseRelation>(keyWeekHomeworks);
  void addWeekHomework(ParseObject parseHomwork) =>
      addWeekHomeworks([parseHomwork]);
  void addWeekHomeworks(List<ParseObject> parseHomworks) =>
      super.addRelation(keyWeekHomeworks, parseHomworks);
  void removeWeekHomework(ParseObject parseHomwork) =>
      removeWeekHomeworks([parseHomwork]);
  void removeWeekHomeworks(List<ParseObject> parseHomworks) =>
      super.removeRelation(keyWeekHomeworks, parseHomworks);
}
