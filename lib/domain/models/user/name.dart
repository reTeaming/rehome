import 'package:equatable/equatable.dart';

class Name extends Equatable {
  const Name(this.name, this.surname);

  final String name;
  final String surname;

  @override
  List<Object> get props => [name, surname];

  static const empty = Name('-', '-');
}
