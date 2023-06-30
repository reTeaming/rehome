import 'package:equatable/equatable.dart';
import 'package:rehome/domain/models/user/id.dart';

class Institution extends Equatable {
  const Institution(this.organisationId, this.name, this.departement);

  final Id organisationId;
  final String name;
  final String departement;

  @override
  List<Object> get props => [organisationId, name, departement];

  static const mock = Institution(Id.mock, '-', '-');
}
