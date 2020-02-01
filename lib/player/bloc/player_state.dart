import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerState extends Equatable {
  const PlayerState();
}

class SelectNumberPlayer extends PlayerState {
  @override
  List<Object> get props => [];
}

class InputNamesPlayer extends PlayerState {
  @override
  List<Object> get props => [];
}


class PlayerError extends PlayerState {
  @override
  List<Object> get props => [];
}
