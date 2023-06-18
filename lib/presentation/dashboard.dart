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
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
