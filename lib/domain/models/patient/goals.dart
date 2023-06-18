import 'package:equatable/equatable.dart';

class Goals extends Equatable {
  const Goals(this.goals);

  final List<Goal> goals;

  @override
  List<Object> get props => [goals];

  void addGoal(Goal goal) async {
    goals.add(goal);
  }
}

class Goal extends Equatable {
  const Goal(this.status, this.description);

  final GoalStatus status;
  final String description;

  @override
  List<Object> get props => [status, description];
}

enum GoalStatus { inactive, active, achieved}
