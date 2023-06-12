import 'package:ReHome/domain/models/auth/models.dart';
import 'package:ReHome/domain/models/user/id.dart';
import 'package:ReHome/domain/models/user/institution.dart';
import 'package:ReHome/domain/models/user/name.dart';
import 'package:equatable/equatable.dart';

// Daten Model, dass den Endnutzer der App beschreiben und eindeutig identifizieren soll.
// Hier wird nicht der Patient abgebildet.
class User extends Equatable {
  const User(this.id, this.name, this.username, this.institution);

  final Id id;
  final Name name;
  final Username username;
  final Institution institution;

  @override
  List<Object> get props => [id, name, username, institution];

  static const empty =
      User(Id.mock, Name.empty, Username.pure(), Institution.mock);
}
