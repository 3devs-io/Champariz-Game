import 'package:champariz_game/card/models/card.dart';
import 'package:champariz_game/player/models/player.dart';
import 'package:champariz_game/card/models/card.dart' as cards;

class Game {
  int numberOfPlayers;
  List<Player> playerList;
  Deck deck;
  Player currentPlayer;
  Deck actualDeck;

  Game(int numberOfPlayers) {
    this.numberOfPlayers = numberOfPlayers;
    this.playerList = List<Player>();
    this.deck = Deck();
    this.actualDeck = deck;
  }

  addPlayer(Player playerToAdd) {
    this.playerList.add(playerToAdd);
  }

  initGame() {
    currentPlayer = playerList[0]; //Setting up first player
    deck.cards.shuffle(); //Randomizing cards
  }

  removeCardFromDeck(cards.Card cardToRemove) {
    actualDeck.cards.remove(cardToRemove);
    print(actualDeck.cards.length);
  }
}
