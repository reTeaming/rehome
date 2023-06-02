import 'package:equatable/equatable.dart';

class Institution extends Equatable {
  const Institution(this.organisationId, this.name, this.departement);

  final String organisationId;
  final String name;
  final String departement;

  @override
  List<Object> get props => [organisationId, name, departement];

  static const empty = Institution('-', '-', '-');
}
