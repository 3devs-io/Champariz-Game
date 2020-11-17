import 'package:champariz_game/game/models/game.dart';
import 'package:champariz_game/player/models/player.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/game.dart';

@immutable
abstract class GameState extends Equatable {
  const GameState();
}

class UnloadedGame extends GameState {
  @override
  List<Object> get props => [];
}

class PlayingState extends GameState {
  const PlayingState();

  @override
  List<Object> get props => [];
}

class DrinkState extends GameState {
  const DrinkState();

  @override
  List<Object> get props => [];
}

class GiveDrinkState extends GameState {
  const GiveDrinkState();

  @override
  List<Object> get props => [];
}

class StatsState extends GameState {
  const StatsState();

  @override
  List<Object> get props => [];
}

class EndState extends GameState {
  const EndState();

  @override
  List<Object> get props => [];
}
