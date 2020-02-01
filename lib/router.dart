import 'package:champariz_game/gameView.dart';
import 'package:champariz_game/home.dart';
import 'package:flutter/material.dart';

const String HomeRoute = '/';
const String GameViewRoute = 'gameView';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case GameViewRoute:
      return MaterialPageRoute(builder: (context) => GameView());
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}
