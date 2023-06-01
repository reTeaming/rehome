import 'package:formz/formz.dart';

// Fehler die bei der Nutzernamen eingabe auftreten können
enum UsernameValidationError { empty }

// Validierung der Nutzereingaben mittels des Formz package.
// Anforderungen an den Nutzernamen:
//   - nicht leer
class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    return null;
  }
}
