import 'package:flutter/material.dart';

/// [ChangeNotifier] is a class in `flutter:foundation`. [AutoPlayStatesModel] does
/// _not_ depend on Provider.

class AutoPlayStatesModel with ChangeNotifier {
  int cardCountOnDeck = -5;
  String name = '';
  bool isShowPlayerMatchStatus = false;

  int indexOfP1Card = 0;

  String playerOneLeft = '08';
  String playerTwoLeft = '08';

  String playerOnePoint = '00';
  String playerTwoPoint = '00';

  String playerOneTrump = '00';
  String playerTwoTrump = '00';

  bool isCardOneTouched = false;
  bool isCardTwoTouched = false;

  String attributeValue = '';
  String player1TotalPoints = '66';
  String player2TotalPoints = '22';


  void updateAutoPlayStates(
      int indexOfP1Card,
      String attributeTitle,
      String attributeValue,
      String cardId,
      bool isCardOneTouched,
      bool isCardTwoTouched
      ) {

    name = 'Kiron';

    this.indexOfP1Card = indexOfP1Card;

    this.playerOneLeft = '10';
    this.playerTwoLeft = '11';

    this.playerOnePoint = '22';
    this.playerTwoPoint = '11';

    this.playerOneTrump = '8';
    this.playerTwoTrump = '2';

    this.isCardOneTouched = isCardOneTouched;
    this.isCardTwoTouched = isCardTwoTouched;
    this.attributeValue = attributeValue;

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
}