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

class LoadingGame extends GameState {
  final Game game;

  const LoadingGame(this.game);
  @override
  List<Object> get props => [game.actualDeck.cards];
}

class EndedGame extends GameState {
  final List<Player> playerList;
  EndedGame(this.playerList);
  @override
  List<Object> get props => [playerList];
}

class GameError extends GameState {
  @override
  List<Object> get props => [];
}

class GiveDrinkState extends GameState {
  final List<Player> players;
  final Player player;
  final int sips;

  const GiveDrinkState(this.players, this.player, this.sips);

  @override
  List<Object> get props => [players, player, sips];
}

class FinishDrinkState extends GameState {
  final Player player;

  const FinishDrinkState(this.player);

  @override
  List<Object> get props => [player];
}

class EveryoneDrinkState extends GameState {
  const EveryoneDrinkState();

  @override
  List<Object> get props => [];
}

class SoloDrinkState extends GameState {
  final Player player;
  final int sips;
  const SoloDrinkState(this.player, this.sips);

  @override
  List<Object> get props => [player, sips];
}

class DrinkingGame extends GameState {
  final Player player;
  final bool isFinished;

  const DrinkingGame(this.player, this.isFinished);

  @override
  List<Object> get props => [player, isFinished];
}
