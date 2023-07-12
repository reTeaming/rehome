import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rehome/data/models/parse_defaultexercise.dart';
import 'package:rehome/domain/models/patient/default_exercise.dart';
import 'package:equatable/equatable.dart';
import 'package:rehome/data/models/parse_cocontraction.dart';
import 'package:rehome/data/models/parse_exercise.dart';
import 'package:rehome/data/models/parse_jerk.dart';
import 'package:rehome/data/models/parse_parameterSet.dart';
import 'package:rehome/data/models/parse_rangeofmotion.dart';

class Exercise extends Equatable {
  static Future<Exercise?> fromParse(ParseExercise exercise) async {
    return await _buildExerciseFromParse(exercise);
  }

  const Exercise(this.exerciseType, this.parameter, this.results);

  final DefaultExercise exerciseType;
  final List<ParameterSet> parameter;
  final Map<DateTime, List<ParameterSet>> results;

  @override
  List<Object> get props => [exerciseType, parameter, results];

  static Future<Exercise?> _buildExerciseFromParse(
      ParseExercise exercise) async {
    final DefaultExercise? parsedDefaultExercise =
        exercise.defaultExercise != null
            ? ((await ParseDefaultExercise()
                        .getObject(exercise.defaultExercise!.objectId!))
                    .results!
                    .first as ParseDefaultExercise)
                .toDefaultExercise()
            : null;

    final List<ParameterSet> parameter = await _getParameters(exercise);
    final Map<DateTime, List<ParameterSet>> results =
        await _getResults(exercise);

    if (parsedDefaultExercise == null) {
      return null;
    }
    return Exercise(parsedDefaultExercise, parameter, results);
  }

  static Future<List<ParameterSet>> _getParameters(
      ParseExercise exercise) async {
    if (exercise.parameterSets == null) {
      return List.empty();
    }

    final List<ParseObject> parseParameterSets =
        await exercise.parameterSets!.getQuery().find();

    final List<ParameterSet> parameters = List.empty(growable: true);

    for (var parseParameterSet in parseParameterSets) {
      final ParseParameterSet parameterSet = ParseParameterSet()
        ..fromJson(parseParameterSet.toJson());
      ParameterSet? parsedExercise = await parameterSet.toParameterSet();
      if (parsedExercise != null) {
        parameters.add(parsedExercise);
      }
    }

    return parameters;
  }

  static Future<Map<DateTime, List<ParameterSet>>> _getResults(
      ParseExercise exercise) async {
    //TODO: implement: eventuelles Ändern der Backend Struktur von Results
    return {};
  }
}

abstract class ParameterSet extends Equatable {
  const ParameterSet(this.name, this.repetition);

  final String name;
  final int repetition;

  @override
  List<Object> get props => [name, repetition];
}

extension ToParameterSet on ParseParameterSet {
  Future<ParameterSet?> toParameterSet() async {
    if (cocontraction != null) {
      return ((await ParseCocontraction().getObject(cocontraction!.objectId!))
              .results!
              .first as ParseCocontraction)
          .toCocontraction(this);
    } else if (jerk != null) {
      return ((await ParseJerk().getObject(jerk!.objectId!)).results!.first
              as ParseJerk)
          .toJerk(this);
    } else if (rangeOfMotion != null) {
      return ((await ParseRangeOfMotion().getObject(rangeOfMotion!.objectId!))
              .results!
              .first as ParseRangeOfMotion)
          .toRangeOfMotion(this);
    }
    return null;
  }
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

extension ToCocontraction on ParseCocontraction {
  Cocontraction toCocontraction(ParseParameterSet parameterSet) {
    return Cocontraction(
        ParameterValue(extensor1),
        ParameterValue(extensor2),
        ParameterValue(extensor3),
        ParameterValue(flexor1),
        ParameterValue(flexor2),
        ParameterValue(flexor3),
        parameterSet.name,
        parameterSet.repetition);
  }
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

extension ToJerk on ParseJerk {
  Jerk toJerk(ParseParameterSet parameterSet) {
    return Jerk(
        ParameterValue(value), parameterSet.name, parameterSet.repetition);
  }
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

extension ToRangeOfMotion on ParseRangeOfMotion {
  RangeOfMotion toRangeOfMotion(ParseParameterSet parameterSet) {
    return RangeOfMotion(joint.toJoint(), ParameterValue(value),
        parameterSet.name, parameterSet.repetition);
  }
}

enum Joint { ellbow, wrist, shoulder }

extension ToJoint on String {
  Joint toJoint() {
    switch (this) {
      case "ellbow":
        return Joint.ellbow;
      case "shoulder":
        return Joint.shoulder;
      default:
        return Joint.wrist;
    }
  }
}

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
