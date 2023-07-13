import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/domain/models/patient/homework.dart';

import '../business_logic/default_exercise/default_exercise_bloc.dart';
import '../domain/models/patient/exercise.dart';

class ExBlockPage extends StatelessWidget {
  final ExerciseBlock? activeExBlock;

  const ExBlockPage(this.activeExBlock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          activeExBlock!.name,
          style: const TextStyle(
            fontSize: 36.0,
            decoration: TextDecoration.underline,
          ),
        ),
        const Divider(
          height: 10,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Übungen in diesem Block:",
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        const Divider(
          height: 10,
        ),
        BlocBuilder<DefaultExerciseBloc, DefaultExerciseState>(
          builder: (context, state) {
            return Builder(builder: (BuildContext context) {
              final List<Exercise> exercises =
                  activeExBlock!.block; //Liste der Übungen in diesem Block
              final List<ListTile> exerciseTiles = exercises.map((Exercise e) {
                return ListTile(
                    key: Key(e.exerciseType.name),
                    title: Text(e.exerciseType.name),
                    onTap: () {
                      // Weiterleitung zur Übung
                      context.read<DefaultExerciseBloc>().add(
                          ActiveBlocktoExercise(
                              activeExBlock!, e.exerciseType));
                    });
              }).toList();

              return ListView(
                shrinkWrap: true,
                children: exerciseTiles,
              );
            });
          },
        )
      ],
    );
  }
}
