// Erster Entwurf vom Dashboard (erstmal hauptsächlich um das Scrollbar Widget zu testen)
import 'package:ReHome/business_logic/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ReHome/presentation/searchwidget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});
  

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DashBoard());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ReorderableListView Sample')),
        body:  SearchWidget(dummyList), 
      ),
    );
  }
}