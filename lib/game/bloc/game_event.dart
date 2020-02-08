import 'package:champariz_game/game/models/game.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:champariz_game/card/models/card.dart' as cards;

@immutable
abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameLoading extends GameEvent {
  final Game game;

  const GameLoading(this.game);

  @override
  List<Object> get props => [game];
}

class CardTappedGame extends GameEvent {
  final Game game;
  final cards.Card tapped;

  const CardTappedGame(this.game, this.tapped);

  @override
  List<Object> get props => [game, tapped];
}

class LoadGame extends GameEvent {
  @override
  List<Object> get props => [];
}
