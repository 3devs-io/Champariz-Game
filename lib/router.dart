import 'package:champariz_game/gameview.dart';
import 'package:champariz_game/home.dart';
import 'package:flutter/material.dart';

const String homeRoute = '/';
const String gameViewRoute = 'gameView';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case gameViewRoute:
      return MaterialPageRoute(builder: (context) => const GameView());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => const Home());
    default:
      return MaterialPageRoute(builder: (context) => const Home());
  }
}
