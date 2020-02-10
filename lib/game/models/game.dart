import 'package:champariz_game/game/models/card.dart';
import 'package:champariz_game/player/models/player.dart';
import 'package:champariz_game/game/models/card.dart' as cards;

class Game {
  int numberOfPlayers;
  List<Player> playerList;
  Deck deck;
  Player currentPlayer;
  Deck actualDeck;
  cards.Card lastCardPlayed;

  Game(int numberOfPlayers) {
    this.numberOfPlayers = numberOfPlayers;
    this.playerList = List<Player>();
    this.deck = Deck();
    this.actualDeck = Deck.fromCards(this.deck.cards);
  }

  addPlayer(Player playerToAdd) {
    this.playerList.add(playerToAdd);
  }

  nextPlayer() {
    int index = this.playerList.indexOf(this.currentPlayer);
    if (index == this.playerList.length) {
      this.currentPlayer = this.playerList[0];
    } else {
      this.currentPlayer = this.playerList[index + 1];
    }
    lastCardPlayed = null;
  }

  initGame() {
    currentPlayer = playerList[0]; //Setting up first player
    deck.cards.shuffle(); //Randomizing cards
  }

  play(cards.Card cardToRemove) {
    actualDeck.cards.remove(cardToRemove);
    lastCardPlayed = cardToRemove;
  }
}
