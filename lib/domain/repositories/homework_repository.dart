import 'package:rehome/data/backend_homework.dart';
import 'package:rehome/domain/models/patient/homework.dart';
import 'package:rehome/domain/models/user/id.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HomeworkRepository {
  static Future<bool> createHomework(Homework homework) async {
    ParseResponse response = await HomeworkBackend.saveHomework(homework);
    return response.success;
  }

  /// Sucht im Backend nach Hausaufgabe mit gegebener Id
  static Future<Homework?> getHomeworkById(Id id) async {
    String stringId = id.id;

    final ParseResponse response =
        await ParseObject('Homework').getObject(stringId);

    if (response.success) {
      return HomeworkBackend.parseToHomework(response.results!.first);
    }
    return null;
  }
}
