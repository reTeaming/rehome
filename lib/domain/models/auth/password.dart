import 'package:formz/formz.dart';

// Fehler die bei der Nutzernamen eingabe auftreten können
enum PasswordValidationError { empty }

// Validierung der Nutzereingaben mittels des Formz package.
// Anforderungen an das Passwort:
//   - nicht leer
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    return null;
  }
}
