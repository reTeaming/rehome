import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:basic_app/types.dart';
import 'package:mutex/mutex.dart';

final globalStorageMutex = ReadWriteMutex();

Future<String> get localDir async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/// Base class for Storage objects, which enable creation and manipulation of
/// user data on disk
abstract class Storage {
  final String name;

  Storage(this.name);

  Future<String> get localFilePath;

  Future<File> get localFile async {
    return File(await localFilePath);
  }

  Future<bool> get exists async {
    final file = await localFile;
    return file.exists();
  }

  Future<void> create();

  Future<Map<String, dynamic>> read();

  Future<void> write(Map<String, dynamic> json);
}

/// Access to and manipulation of unencrypted data models on disk
class JsonStorage extends Storage {
  JsonStorage(String name) : super(name);

  Future<String> get localFilePath async {
    final path = await localDir;
    return '$path/$name.json';
  }

  Future<void> create() async {}

  Future<Map<String, dynamic>> read() async {
    return await globalStorageMutex.protectRead(() async {
      return jsonDecode(await readPlain(await localFile));
    });
  }

  Future<void> write(Map<String, dynamic> json) async {
    await globalStorageMutex.protectWrite(() async {
      print('write');
      var timestamp = DateTime.now();
      json.addAll({'datetime': timestamp.toString()});
      json.addAll({'appversion': VERSION.toString()});
      final contents = utf8.encode(jsonEncode(json));

      final file = await localFile;
      await file.writeAsBytes(contents, flush: true);
    });
  }
}

Future<String> readPlain(File file) async {
  var data = await file.readAsBytes();
  return utf8.decode(data);
}
