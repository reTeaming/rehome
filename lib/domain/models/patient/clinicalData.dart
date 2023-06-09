import 'package:equatable/equatable.dart';

class ClinicalData extends Equatable {
  const ClinicalData(this.paresisSide, this.lastStroke, this.clinicalTest);
  final Enum paresisSide;
  final DateTime lastStroke;
  final List<ClinicalTest> clinicalTest;

  @override
  List<Object> get props => [paresisSide, lastStroke, clinicalTest];
}

enum ParesisSide { LEFT, RIGHT, BOTH }

abstract class ClinicalTest extends Equatable {
  const ClinicalTest(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class FuglMeyerScale extends ClinicalTest {
  const FuglMeyerScale(
    this.sensivity,
    this.reflexes,
    this.hand,
    this.arm,
    this.pain,
    String name,
  ) : super(name);

  final int sensivity;
  final int reflexes;
  final int hand;
  final int arm;
  final int pain;

  static const empty = FuglMeyerScale(0, 0, 0, 0, 0, '');

  @override
  List<Object> get props =>
      super.props + [sensivity, reflexes, hand, arm, pain];
}

class BroetzScale extends ClinicalTest {
  const BroetzScale(
    String name,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
  ) : super(name);

  final int score1;
  final int score2;
  final int score3;
  final int score4;

  static const empty = BroetzScale('', 0, 0, 0, 0);

  @override
  List<Object> get props => super.props + [score1, score2, score3, score4];
}
