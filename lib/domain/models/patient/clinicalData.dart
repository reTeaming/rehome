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

abstract class ClinicalTest {
  String name;
  FuglMeyerScale resultsF;
  BroetzScale resultsB;

  ClinicalTest(this.name, this.resultsF, this.resultsB);
}

class FuglMeyerScale extends Equatable {
  const FuglMeyerScale(
      this.sensivity, this.reflexes, this.hand, this.arm, this.pain);

  final int sensivity;
  final int reflexes;
  final int hand;
  final int arm;
  final int pain;

  @override
  List<Object> get props => [sensivity, reflexes, hand, arm, pain];

  static const empty = FuglMeyerScale(0, 0, 0, 0, 0);
}

class BroetzScale extends Equatable {
  const BroetzScale(this.score1, this.score2, this.score3, this.score4);

  final int score1;
  final int score2;
  final int score3;
  final int score4;

  @override
  List<Object> get props => [score1, score2, score3, score4];

  static const empty = BroetzScale(0, 0, 0, 0);
}
