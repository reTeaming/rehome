import 'package:flutter/material.dart';
import '../domain/models/patient/default_exercise.dart';

class ExercisePage extends StatelessWidget {
  final DefaultExercise? activeExercise;

  const ExercisePage(this.activeExercise, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(activeExercise!.name)],
    );
  }
}
