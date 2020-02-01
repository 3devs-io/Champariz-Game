import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameState extends Equatable {
  const GameState();
}

class GameLoading extends GameState {
  @override
  List<Object> get props => [];
}

class GameLoaded extends GameState {
  @override
  List<Object> get props => [];
}


class GameError extends GameState {
  @override
  List<Object> get props => [];
}
