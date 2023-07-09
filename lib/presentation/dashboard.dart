import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/auth/auth_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Dashboard());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'Willkommen, das ist das Dashboard',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
          width: 220,
          child: Divider(
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ]),
    ));
  }
}
