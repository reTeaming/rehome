import 'package:rehome/data/backend_homework.dart';
import 'package:rehome/domain/models/patient/homework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HomeworkRepository {
  static Future<bool> createHomework(Homework homework) async {
    ParseResponse response = await HomeworkBackend.saveHomework(homework);
    return response.success;
  }
}
