import 'package:champariz_game/home.dart';
import 'package:champariz_game/res/router.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xff2e5077),
          accentColor: Color(0xff4da1a9),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      home: Home(),
      initialRoute: HomeRoute,
      onGenerateRoute: generateRoute,
    );
  }
}