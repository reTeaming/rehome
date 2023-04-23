import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:basic_app/db/storage.dart';
import 'package:uuid/uuid.dart';

const String USER_STORAGE_NAME = 'user';

class UserAccountData extends ChangeNotifier {
  String _nickname;
  final DateTime signedUpDate;
  final UserFavouriteSports favouriteSports;
  UserAccountData(this._nickname, this.signedUpDate, this.favouriteSports);

  UserAccountData.fromJson(Map<String, dynamic> json)
      : _nickname = json['nickname'],
        signedUpDate = DateTime.parse(json['signedUpDate']),
        favouriteSports = UserFavouriteSports.fromJson(json['favouriteSports']);

  Map<String, dynamic> toJson() => {
        'nickname': _nickname,
        'signedUpDate': signedUpDate.toIso8601String(),
        'favouriteSports': favouriteSports
      };

  String get nickname => _nickname;
  set nickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }
}

class UserFavouriteSports extends ChangeNotifier {
  List<String> _favourites;

  UserFavouriteSports(List<String> this._favourites);

  UserFavouriteSports.fromJson(Map<String, dynamic> json)
      : _favourites =
            (json['favourites'] as List).map((e) => e.toString()).toList();

  Map<String, dynamic> toJson() => {'favourites': _favourites};

  List<String> get favourites => _favourites;
  set favourites(List<String> favourites) {
    _favourites = favourites;
    notifyListeners();
  }

  void addSport(String sport) async {
    _favourites.add(sport);
    notifyListeners();
  }
}

/// ## Data Container for users incl. (de)serialization
class UserModel extends ChangeNotifier {
  late String _code;
  late UserAccountData _userAccountData;

  UserModel(String code, UserAccountData userAcountData) {
    _code = code.toLowerCase().replaceAll(" ", "");
    _userAccountData = userAcountData;
    _userAccountData.addListener(notifyListeners);
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _userAccountData = json.containsKey('userAccountData')
        ? UserAccountData.fromJson(json['userAccountData'])
        : UserAccountData("unknown", DateTime.now(), UserFavouriteSports([""]));

    _userAccountData.addListener(notifyListeners);
  }

  Map<String, dynamic> toJson() =>
      {'code': _code, 'userAccountData': _userAccountData};

  String get code => _code;

  UserAccountData get userAccountData => _userAccountData;

  set userAccountData(UserAccountData data) {
    _userAccountData = data;
    notifyListeners();
  }
}

Future<bool> userModelExists() {
  var jsonStorage = JsonStorage(USER_STORAGE_NAME);
  return jsonStorage.exists;
}

Future<void> createUserModel(String code) async {
  var jsonStorage = JsonStorage(USER_STORAGE_NAME);
  await jsonStorage.create();
  var userModel = UserModel(code,
      UserAccountData("unknown", DateTime.now(), UserFavouriteSports([""])));
  await jsonStorage.write(userModel.toJson());
}

Future<UserModel> getUserModel() async {
  var jsonStorage = JsonStorage(USER_STORAGE_NAME);
  var json = await jsonStorage.read();
  var userModel = UserModel.fromJson(json);
  userModel.addListener(() {
    jsonStorage.write(userModel.toJson());
  });
  return userModel;
}
