import 'package:ReHome/domain/models/user/institution.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:ReHome/domain/models/user/user.dart';
import 'package:ReHome/domain/models/user/id.dart';
import 'package:ReHome/domain/models/user/name.dart';
import 'package:ReHome/domain/models/auth/username.dart';

class UserAuth {
  // Authentifizierung von Endbenutzern durch Backend
  // User wird anhand vom gegebenem Nutzernamen und Passwort authentifiziert
  // Rückgabewert ist der nun eingeloggte Benutzer (nach unserem Datenmodell) oder null
  Future<User?> authUser(String username, String password) async {
    final user = ParseUser(username.trim(), password, null);

    var response = await user.login();
    if (response.success) return initUser(user);
    return null;
  }

  // Bekommt ein ParseUser und macht einen User nach unserer Datenstruktur daraus
  // Dieser wird zurückgegeben
  Future<User> initUser(ParseUser parseUser) async {
    // Erstellt eine Id aus der ObjektId des ParseUsers
    Id id = Id(parseUser.get('objectId'));

    // Entnimmt den Namen aus dem ParseUser, spaltet ihn in Vor- und Nachname und Erstellt Name-Objekt
    String nameString = parseUser.get('name');
    List<String> nameSplit = nameString.split(' ');
    Name name = Name(nameSplit.first, nameSplit.last);

    // Erstellt Username aus ParseUser-Username
    Username username = Username.dirty(parseUser.get('username'));

    // Erstellt Insitution aus ParseUser-Institution, falls keine gespeichert ist wird Mock erstellt
    Institution institution = await initInstitution(parseUser);

    // User-Objekt wird aus Id, Name, Username und Institution erstellt
    User user = User(id, name, username, institution);
    return user;
  }

  // Bekommt einen ParseUser und liest die Institution von diesem
  // Gibt die Institution in unserem Datenmodel zurück
  Future<Institution> initInstitution(ParseUser parseUser) async {
    // Institutions Eintrag in User Datenbank speichern
    var institutionKey = parseUser.get('institution');

    // Suche nach Institution mit objectId, welcher mit dem Eintrag in User übereinstimmt
    QueryBuilder<ParseObject> queryInstitution =
        QueryBuilder<ParseObject>(ParseObject('Institution'))
          ..whereContains('objectId', institutionKey.get('objectId'));

    // starte query-Suche und speichere die Antwort
    var response = await queryInstitution.query();

    // Auslesen der Institution falls vorhanden
    var parseInstitution = response.results!.first;

    // Falls keine Institution gefunden wurde, gebe Institutions-Mock zurück
    if (!response.success || response.results == null) return Institution.mock;

    // Auslesen des Namens, der Id und dem Department der Institution
    var institutionName = parseInstitution.get('name');
    var institutionId = Id(parseInstitution.get('objectId'));
    var institutionDepartment = parseInstitution.get('department');

    // gebe Institution aus Id, Name und Department zurück
    return Institution(institutionId, institutionName, institutionDepartment);
  }

  // Registrierung von Endbenutzern (NUR für Entwicklungszwecke)
  // Benutzer wird mit gegebenem Nutzernamen und Passwort einer generierten Email-Adresse (anhand von Nutzernamen) erstellt
  Future<bool> createUser(String username, String password,
      [String? email]) async {
    final usernameTrimmed = username.trim();
    final passwordTrimmed = password.trim();
    final emailTrimmed =
        (email == null) ? "$usernameTrimmed@gmail.com".trim() : email.trim();

    final user =
        ParseUser.createUser(usernameTrimmed, passwordTrimmed, emailTrimmed);

    var response = await user.signUp();

    return response.success;
  }
}
