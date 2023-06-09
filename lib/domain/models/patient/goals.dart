import 'package:equatable/equatable.dart';

class Goals extends Equatable{
  const Goals(this.goals);

  final List<Goal> goals;

  @override
  List<Object> get props => [goals];

  void addGoal(Goal goal) async {
    goals.add(goal);
  }
}

class Goal extends Equatable {
  const Goal(this.status, this.description)
  Status status;
  String description;
  Goal(this.status, this.description);
}

enum Status { inactive, active, achieved, inProcess }
