import 'package:champariz_game/card/models/card.dart';
import 'package:champariz_game/player/models/player.dart';

class Game {
  int numberOfPlayers;
  List<Player> playerList;
  Deck deck;
  Player currentPlayer;

  Game(int numberOfPlayers) {
    this.numberOfPlayers = numberOfPlayers;
    this.playerList = List<Player>();
    this.deck = Deck();
  }

  addPlayer(Player playerToAdd) {
    this.playerList.add(playerToAdd);
  }
}
