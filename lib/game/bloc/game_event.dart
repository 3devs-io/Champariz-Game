import 'package:champariz_game/game/models/game.dart';
import 'package:champariz_game/player/models/player.dart';
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

class GaveDrinkEvent extends GameEvent {
  final Player player;
  final int sips;
  const GaveDrinkEvent(this.player, this.sips);
  @override
  List<Object> get props => [player, sips];
}

class DrankEvent extends GameEvent {
  final List<Player> playersList;
  final int sips;
  const DrankEvent(this.playersList, this.sips);

  @override
  List<Object> get props => [playersList, sips];
}

class StatsSeenEvent extends GameEvent {
  const StatsSeenEvent();
  @override
  List<Object> get props => [];
}

class StatsDebug extends GameEvent {
  const StatsDebug();
  @override
  List<Object> get props => [];
}
