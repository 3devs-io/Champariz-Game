import 'package:champariz_game/game/models/game.dart';
import 'package:champariz_game/player/models/player.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

class GameError extends GameState {
  @override
  List<Object> get props => [];
}

class DrinkingGame extends GameState {
  final String toDrink;
  final Player player;

  const DrinkingGame(this.toDrink, this.player);

  @override
  List<Object> get props => [toDrink, player];
}
