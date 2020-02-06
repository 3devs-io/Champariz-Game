import 'package:champariz_game/game/models/game.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CardState extends Equatable {
  const CardState();
}

class HiddenCard extends CardState {
  @override
  List<Object> get props => [];
}

class ShownCard extends CardState {
  @override
  List<Object> get props => [];
}
