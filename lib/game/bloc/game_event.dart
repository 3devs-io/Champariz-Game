import 'package:champariz_game/game/models/game.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:champariz_game/game/models/card.dart' as cards;

@immutable
abstract class GameEvent extends Equatable {
  const GameEvent();
}

class LoadGameEvent extends GameEvent {
  final Game game;

  const LoadGameEvent(this.game);

  @override
  List<Object> get props => [game];
}

class CardRevealEvent extends GameEvent {
  final cards.Card tapped;

  const CardRevealEvent(this.tapped);

  @override
  List<Object> get props => [tapped];
}

class DrankEvent extends GameEvent {
  const DrankEvent();

  @override
  List<Object> get props => [];
}

class GaveDrinkEvent extends GameEvent {
  const GaveDrinkEvent();
  @override
  List<Object> get props => [];
}

class StatsSeenEvent extends GameEvent {
  const StatsSeenEvent();
  @override
  List<Object> get props => [];
}
