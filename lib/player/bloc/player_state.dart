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
  final int playerNumber;

  const InputNamesPlayer(this.playerNumber);

  @override
  List<Object> get props => [playerNumber];
}

class PlayerError extends PlayerState {
  @override
  List<Object> get props => [];
}
