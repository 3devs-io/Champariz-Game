import 'package:champariz_game/game/models/game.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerState extends Equatable {
  const PlayerState();
}

class SelectingNumberPlayers extends PlayerState {
  @override
  List<Object> get props => [];
}

class InputNamesPlayer extends PlayerState {
  final Game game;

  const InputNamesPlayer(this.game);

  @override
  List<Object> get props => [game];
}

class PlayerError extends PlayerState {
  @override
  List<Object> get props => [];
}
