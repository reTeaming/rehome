import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:equatable/equatable.dart';

class ExerciseDefaultData extends Equatable {
  const ExerciseDefaultData(this.id, this.parameters);

  final int id;
  final List<ParameterSet> parameters;

  @override
  List<Object> get props => [id, parameters];
}
