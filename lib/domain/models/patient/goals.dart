import 'package:equatable/equatable.dart';
import 'package:rehome/data/models/parse_goal.dart';

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

enum GoalStatus { inactive, active, achieved }

extension ToGoalStatus on String {
  GoalStatus toGoalStatus() {
    switch (this) {
      case "inactive":
        return GoalStatus.inactive;
      case "achieved":
        return GoalStatus.achieved;
      default:
        return GoalStatus.active;
    }
  }
}

extension ToGoal on ParseGoal {
  Goal toGoal() {
    return Goal(status.toGoalStatus(), description);
  }
}
