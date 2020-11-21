import 'package:champariz_game/game/models/card.dart';
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

class PlayingState extends GameState {
  final Player actualPlayer;
  final List<Card> deck;

  const PlayingState(this.actualPlayer, this.deck);

  @override
  List<Object> get props => [actualPlayer, deck];
}

class DrinkState extends GameState {
  final Player actualPlayer;
  final int sips;
  const DrinkState(this.actualPlayer, this.sips);

  @override
  List<Object> get props => [actualPlayer, sips];
}

class FinishDrinkState extends GameState {
  final Player actualPlayer;

  const FinishDrinkState(this.actualPlayer);

  @override
  List<Object> get props => [actualPlayer];
}

class GiveDrinkState extends GameState {
  final Player actualPlayer;
  final int sips;
  const GiveDrinkState(this.actualPlayer, this.sips);

  @override
  List<Object> get props => [actualPlayer, sips];
}

class EveryoneDrinkState extends GameState {
  final List<Player> playersList;
  const EveryoneDrinkState(this.playersList);

  @override
  List<Object> get props => [playersList];
}

class StatsState extends GameState {
  final List<Player> playersList;
  const StatsState(this.playersList);

  @override
  List<Object> get props => [playersList];
}

class EndState extends GameState {
  const EndState();

  @override
  List<Object> get props => [];
}
