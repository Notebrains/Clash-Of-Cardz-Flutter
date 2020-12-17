import 'package:flutter/material.dart';

/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.

class AutoPlayStatesModel with ChangeNotifier {
  int value = 0;
  String name = '';

  String index = '0';

  String playerOneLeft = '08';
  String playerTwoLeft = '08';

  String playerOnePoint = '00';
  String playerTwoPoint = '00';

  String playerOneTrump = '00';
  String playerTwoTrump = '00';

  bool isCardOneTouched = true;
  bool isCardTwoTouched = false;
  String attributeValue = '';


  void updateAutoPlayStates(String index, String attributeTitle, String attributeValue, String cardId, bool isCardOneTouched, bool isCardTwoTouched) {
    value += 1;
    name = 'Kiron';

    this.index = index;

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
}