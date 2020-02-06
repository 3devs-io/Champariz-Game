import 'package:champariz_game/game/models/game.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameState extends Equatable {
  const GameState();
}

class GameLoading extends GameState {
  final Game game;

  const GameLoading(this.game);
  @override
  List<Object> get props => [game];
}

class GameLoaded extends GameState {
  @override
  List<Object> get props => [];
}

class GameError extends GameState {
  @override
  List<Object> get props => [];
}
