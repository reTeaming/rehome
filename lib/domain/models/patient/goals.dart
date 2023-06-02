class Goals {
  List<Goal> goals;
  Goals(this.goals);

  void addGoal(Goal goal) async {
    goals.add(goal);
  }
}

class Goal {
  Status status;
  String description;
  Goal(this.status, this.description);
}

enum Status { inactive, active, achieved, inProcess }
