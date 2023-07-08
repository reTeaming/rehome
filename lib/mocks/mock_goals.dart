import 'package:rehome/domain/models/patient/goals.dart';

// Mocks zum Testen von Goal spezifischen Objekten
// Alle hier implementierten Klassen sind zu finden in 'domain/models/patient/goals.dart'
class GoalsMock {
  // Goal Stati
  static GoalStatus achieved = GoalStatus.achieved;
  static GoalStatus active = GoalStatus.active;
  static GoalStatus inactive = GoalStatus.inactive;

  // Goal Objekts
  static Goal goal1 =
      Goal(active, "Volle Funktionsfähigkeit des linken Arms herstellen");
  static Goal goal2 = Goal(active, "beide Handgelenk auf 45° überstrecken");
  static Goal goal3 = Goal(active, "rechten Ellenbogen auf 130° strecken");
  static Goal goal4 = Goal(active, "linke Schulter um 15° heben");
  static Goal goal5 =
      Goal(active, "rechte Hand um 12cm von ebener Oberfläche heben");
  static Goal goal6 = Goal(inactive, "linke Schulter um über 90° heben");
  static Goal goal7 = Goal(inactive, "rechtes Handgelenk um 12° neigen");
  static Goal goal8 = Goal(inactive, "beide Hände um 20cm über Kopf heben");
  static Goal goal9 =
      Goal(inactive, "Volle Funktionsfähigkeit des rechten Arms herstellen");
  static Goal goal10 = Goal(achieved, "linkes Handgelenk um 5° beugen");
  static Goal goal11 =
      Goal(achieved, "rechten Arm um 23cm von Tischkante heben");
  static Goal goal12 = Goal(achieved, "linke Schulter auf mehr als 69° heben");

  // Goal Lists
  static List<Goal> goalList1 = List.empty(growable: true)
    ..add(goal1)
    ..add(goal2);
  static List<Goal> goalList2 = List.empty(growable: true)
    ..add(goal3)
    ..add(goal5);
  static List<Goal> goalList3 = List.empty(growable: true)
    ..add(goal4)
    ..add(goal6)
    ..add(goal9);
  static List<Goal> goalList4 = List.empty(growable: true)
    ..add(goal1)
    ..add(goal8)
    ..add(goal9)
    ..add(goal10)
    ..add(goal12);
  static List<Goal> goalList5 = List.empty(growable: true)
    ..add(goal7)
    ..add(goal8);
  static List<Goal> goalList6 = List.empty(growable: true)
    ..add(goal6)
    ..add(goal12);

  // Goals Objekts
  static Goals goals1 = Goals(goalList1);
  static Goals goals2 = Goals(goalList2);
  static Goals goals3 = Goals(goalList3);
  static Goals goals4 = Goals(goalList4);
  static Goals goals5 = Goals(goalList5);
  static Goals goals6 = Goals(goalList6);
}
