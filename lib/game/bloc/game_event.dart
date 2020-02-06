import 'package:champariz_game/game/models/game.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameEvent extends Equatable {
  const GameEvent();
}

class Init extends GameEvent {
  final Game game;

  const Init(this.game);

  @override
  List<Object> get props => [game];
}

class LoadGame extends GameEvent {
  @override
  List<Object> get props => [];
}