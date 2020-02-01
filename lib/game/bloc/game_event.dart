import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameEvent extends Equatable {
  const GameEvent();
}

class LoadGame extends GameEvent {
  @override
  List<Object> get props => [];
}