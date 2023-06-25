import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Dashboard());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Dashboard")),
    );
  }
}
