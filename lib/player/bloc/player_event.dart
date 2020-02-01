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

class SelectedNames extends PlayerEvent {
  final List<String> playersNames;

  const SelectedNames(this.playersNames);

  @override
  List<Object> get props => [playersNames];
}
