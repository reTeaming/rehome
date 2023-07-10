import 'package:flutter/material.dart';
import 'package:rehome/domain/models/patient/homework.dart';

class ExBlockPage extends StatelessWidget {
  final ExerciseBlock? activeExBlock;

  const ExBlockPage(this.activeExBlock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Block ${activeExBlock!.name}",
          style: TextStyle(
            fontSize: 36.0,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
