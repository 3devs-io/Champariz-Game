import 'package:champariz_game/game/bloc/bloc.dart';
import 'package:champariz_game/home.dart';
import 'package:champariz_game/player/bloc/bloc.dart';
import 'package:champariz_game/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<GameBloc>(
            create: (context) => GameBloc()..add(LoadGame()),
          ),
          BlocProvider<PlayerBloc>(create: (context) => PlayerBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Champariz',
          theme: ThemeData(
            primaryColor: const Color(0xff2e5077),
            accentColor: const Color(0xff4da1a9),
          ),
          home: const Home(),
          initialRoute: homeRoute,
          onGenerateRoute: generateRoute,
        ));
  }
}
