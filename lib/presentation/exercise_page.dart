import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/default_exercise/default_exercise_bloc.dart';
import '../domain/models/patient/default_exercise.dart';

class ExercisePage extends StatelessWidget {
  final DefaultExercise? activeExercise;

  const ExercisePage(this.activeExercise, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DefaultExerciseBloc, DefaultExerciseState>(
            builder: (context, state) {
          switch (state.activeEx) {
            case ActiveExState.activeExercise:
              return Text("");
            case ActiveExState.activeBlocktoExercise:
              return IconButton(
                  onPressed: () =>
                      context.read<DefaultExerciseBloc>().add(BacktoBlock()),
                  icon: const Icon(Icons.arrow_back));
            case ActiveExState.activeExblock:
              return Text("ERROR");
            case ActiveExState.inactive:
              return Text("ERROR");
          }
        }),
        Text(activeExercise!.name),
      ],
    );
  }
}
