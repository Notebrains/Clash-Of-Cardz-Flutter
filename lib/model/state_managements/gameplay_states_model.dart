import 'package:flutter/material.dart';

/// [ChangeNotifier] is a class in `flutter:foundation`. [AutoPlayStatesModel] does
/// _not_ depend on Provider.

class GamePlayStatesModel with ChangeNotifier {
  int cardCountOnDeck = -5;
  String name = '';
  bool isShowPlayerMatchStatus = false;

  int indexOfP1Card = 0;

  int playerOnePoint = 0;
  int playerTwoPoint = 0;

  int playerOneTrump = 0;
  int playerTwoTrump = 0;

  int player1TotalPoints = 0;
  int player2TotalPoints = 0;

  bool isCardOneTouched = false;
  bool isCardTwoTouched = false;
  bool isCardDeckClickedToBuildNewCard = true;

  String attributeValue = '';

  int cardsDeckIndex = 1;

  void updateAutoPlayStates(int indexOfP1Card, String attributeTitle, String attributeValue, bool isCardOneTouched, bool isCardTwoTouched) {
    name = 'Kiron';

    this.indexOfP1Card = indexOfP1Card;
    this.isCardOneTouched = isCardOneTouched;
    this.isCardTwoTouched = isCardTwoTouched;
    this.attributeValue = attributeValue;

    notifyListeners();
  }

  void updatePlayerScoreboards(int playerOneTrump, int playerTwoTrump, int player1TotalPoints, int player2TotalPoints) {
    this.player1TotalPoints = player1TotalPoints;
    this.player2TotalPoints = player2TotalPoints;
    this.playerOneTrump = playerOneTrump;
    this.playerTwoTrump = playerTwoTrump;

    notifyListeners();
  }

  void showPlayerMatchStatus(bool isShowPlayerMathStatus) {
    this.isShowPlayerMatchStatus = isShowPlayerMathStatus;

    notifyListeners();
  }

  void updateCardCountOnDeck(int cardCountOnDeck) {
    this.cardCountOnDeck = cardCountOnDeck;

    notifyListeners();
  }

  void updateRebuildDeck(bool isCardDeckClickedToBuildNewCard) {
    this.isCardDeckClickedToBuildNewCard = isCardDeckClickedToBuildNewCard;

    notifyListeners();
  }
}
