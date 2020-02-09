import 'package:champariz_game/game/models/game.dart';
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
