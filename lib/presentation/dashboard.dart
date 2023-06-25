<<<<<<< HEAD
// Erster Entwurf vom Dashboard (erstmal hauptsächlich um das Scrollbar Widget zu testen)
import 'package:ReHome/business_logic/auth/auth_bloc.dart';
import 'package:ReHome/business_logic/search/bloc/search_bloc.dart';
import 'package:ReHome/domain/repositories/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ReHome/presentation/searchwidget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DashBoard());
=======
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Dashboard());
>>>>>>> b23904cc8575fd1dafb2d1caa35915c0d7bde863
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(searchRepository: SearchRepository()),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Dashboard Sample ')),
          body: Row(
            children: [
              const Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                  )),
              Expanded(flex: 2, child: SearchWidget()),
            ],
          ),
        ),
      ),
=======
    return const Scaffold(
      body: Center(child: Text("Dashboard")),
>>>>>>> b23904cc8575fd1dafb2d1caa35915c0d7bde863
    );
  }
}
