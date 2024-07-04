import 'package:flutter/material.dart';

class CardDecoration {
  final CardType cardType;
  late BoxDecoration test;

  CardDecoration(this.cardType) {
    initializeDecoration(cardType);
  }

  void initializeDecoration(CardType cardType) {
    const double cardCornerRadius = 20;
    const int addIncomeCardAlpha = 127;

    switch (cardType) {
      case CardType.addIncome:
        test = BoxDecoration(
          color: Colors.grey.withAlpha(addIncomeCardAlpha),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(addIncomeCardAlpha),
            width: 10,
          ),
        );
      case CardType.passiveIncome:
        test = const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(cardCornerRadius)),
        );
      case CardType.savingAccounts:
        test = const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(cardCornerRadius)),
        );
    }
  }
}

enum CardType { passiveIncome, savingAccounts, addIncome }
