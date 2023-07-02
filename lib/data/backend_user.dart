import 'package:rehome/domain/models/user/institution.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rehome/domain/models/auth/username.dart';
import 'package:rehome/domain/models/user/name.dart';
import 'package:rehome/domain/models/user/id.dart';

class UserBackend {
  // aktualisiert den Namen eines Benutzers im Backend
  Future<ParseResponse> updateBackendName(Id id, Name newName) async {
    // formt die Daten aus dem Usermodel zu Strings um sie im Backend verarbeiten zu können
    String nameString = "${newName.name} ${newName.surname}";
    String idString = id.id;
    // aktualisert den Namen im Backend beim User mit gegebener Id
    ParseObject user = ParseObject('_User')
      ..objectId = idString
      ..set('name', nameString);
    return await user.save();
  }

  // aktualisiert den Nutzernamen eines Benutzers im Backend
  Future<ParseResponse> updateBackendUsername(
      Id id, Username newUsername) async {
    // formt die Daten aus dem Usermodel zu Strings um sie im Backend verarbeiten zu können
    String usernameString = newUsername.value;
    String idString = id.id;

    // aktualisert den Nutzernamen im Backend beim User mit gegebener Id
    ParseObject user = ParseObject('_User')
      ..objectId = idString
      ..set('username', usernameString);
    return await user.save();
  }

  // aktualisiert die Institution eines Benutzers im Backend
  Future<ParseResponse> updateBackendInstitution(
      Id id, Institution newInstitution) async {
    // formt die Daten aus dem Usermodel zu Strings um sie im Backend verarbeiten zu können
    String idString = id.id;
    String institutionId = newInstitution.organisationId.id;
    String institutionName = newInstitution.name;
    String institutionDepartment = newInstitution.departement;

    // initialisiert ein Institutions-ParseObject
    ParseObject institutionParseObject;

    // schreibe Query zum suchen nach Institution mit gegebener Id
    QueryBuilder<ParseObject> institutionQuery =
        QueryBuilder<ParseObject>(ParseObject('Institution'))
          ..whereEqualTo('objectId', institutionId);
    ParseResponse response = await institutionQuery.query();

    // falls Institution mit gegebener Id gefunden wurde, wird sie als ParseObject gespeichert
    if (response.success && response.count == 1) {
      institutionParseObject = response.result;
    } else {
      // andernfalls wird eine neue erstellt
      institutionParseObject = ParseObject('Institution')
        ..set('name', institutionName)
        ..set('department', institutionDepartment);
    }

    // aktualisiere Institution des Nutzers
    ParseObject user = ParseObject('_User')
      ..objectId = idString
      ..set('institution', institutionParseObject);

    return await user.save();
  }
}
