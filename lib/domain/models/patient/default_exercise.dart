import 'package:rehome/domain/models/user/id.dart';
import 'package:equatable/equatable.dart';

class DefaultExercise extends Equatable {
  const DefaultExercise(this.id, this.name);

  final Id id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
