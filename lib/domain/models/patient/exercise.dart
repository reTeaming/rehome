import 'package:rehome/domain/models/patient/default_exercise.dart';
import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  const Exercise(this.exerciseType, this.parameter, this.results);

  final DefaultExercise exerciseType;
  final List<ParameterSet> parameter;
  final Map<DateTime, List<ParameterSet>> results;

  @override
  List<Object> get props => [exerciseType, parameter, results];
}

abstract class ParameterSet extends Equatable {
  const ParameterSet(this.name, this.repetition);

  final String name;
  final int repetition;

  @override
  List<Object> get props => [name, repetition];
}

class Cocontraction extends ParameterSet {
  const Cocontraction(this.extensor1, this.extensor2, this.extensor3,
      this.flexor1, this.flexor2, this.flexor3, String name, int repetition)
      : super(name, repetition);

  final ParameterValue extensor1;
  final ParameterValue extensor2;
  final ParameterValue extensor3;
  final ParameterValue flexor1;
  final ParameterValue flexor2;
  final ParameterValue flexor3;

  static const defaultparameterset = Cocontraction(
      ParameterValue.defaultvalue,
      ParameterValue.defaultvalue,
      ParameterValue.defaultvalue,
      ParameterValue.defaultvalue,
      ParameterValue.defaultvalue,
      ParameterValue.defaultvalue,
      'co',
      1);

  @override
  List<Object> get props =>
      super.props +
      [extensor1, extensor2, extensor3, flexor1, flexor2, flexor3];
}

class Jerk extends ParameterSet {
  const Jerk(
    this.value,
    String name,
    int repetition,
  ) : super(name, repetition);

  final ParameterValue value;

  @override
  List<Object> get props => super.props + [value];
}

class RangeOfMotion extends ParameterSet {
  const RangeOfMotion(
    this.joint,
    this.value,
    String name,
    int repetition,
  ) : super(name, repetition);

  final Joint joint;
  final ParameterValue value;

  @override
  List<Object> get props => super.props + [joint, value];
}

enum Joint { ellbow, wrist, shoulder }

class ParameterValue extends Equatable {
  const ParameterValue(this.value);

  final double value;

  @override
  List<Object> get props => [value];

  set value(double value) {
    if (value >= 0 && value <= 1) {
      value = value;
    } else {
      throw ArgumentError('Component value must be between 0 and 1.');
    }
  }

  static const defaultvalue = ParameterValue(0);
}
