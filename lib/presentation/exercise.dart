import 'package:flutter/material.dart';
import 'package:rehome/presentation/exercisesearchwidget.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Übungsaufgaben")),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: ExerciseSearchWidget()),
          Flexible(
            flex: 5
            child: 
             )
        ]),
    );
  }
}
