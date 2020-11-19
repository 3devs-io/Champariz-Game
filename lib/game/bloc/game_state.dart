import 'package:champariz_game/game/models/card.dart';
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
  final Player actualPlayer;
  final List<Card> deck;

  const PlayingState(this.actualPlayer, this.deck);

  @override
  List<Object> get props => [actualPlayer, deck];
}

class DrinkState extends GameState {
  final String actualPlayer;
  final String sips;
  const DrinkState(this.actualPlayer, this.sips);

  @override
  List<Object> get props => [];
}

class EveryoneDrinkState extends GameState {
  const EveryoneDrinkState();

  @override
  List<Object> get props => [];
}

class GiveDrinkState extends GameState {
  final String actualPlayer;
  final String sips;
  const GiveDrinkState(this.actualPlayer, this.sips);

  @override
  List<Object> get props => [actualPlayer, sips];
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
