import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class SelectedNumber extends PlayerEvent {
  final int number;

  const SelectedNumber(this.number);

  @override
  List<Object> get props => [number];
}

class SelectName extends PlayerEvent {
  final String name;

  const SelectName(this.name);

  @override
  List<Object> get props => [name];
}

class SelectedNames extends PlayerEvent {
  final List<String> playersNames;

  const SelectedNames(this.playersNames);

  @override
  List<Object> get props => [playersNames];
}

class NewGame extends PlayerEvent {
  const NewGame();

  @override
  List<Object> get props => [];
}
