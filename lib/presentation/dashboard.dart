import 'package:flutter/material.dart';
import 'package:rehome/theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Dashboard());
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: 3,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue[100],
          child: const Text("Statistik 1"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue[200],
          child: const Text('Statistik 2'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue[300],
          child: const Text('Statistik 3'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue[400],
          child: const Text('Statistik 4'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue[500],
          child: const Text('Statistik 5'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue[600],
          child: const Text('Statistik 6'),
        )
      ],
    );
  }
}
