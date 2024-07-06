import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/my_enums.dart';

class CardDecoration {
  final CardType cardType;
  late BoxDecoration boxDecoration;
  late Color splashColor;

  CardDecoration(this.cardType) {
    initializeDecoration(cardType);
  }

  void initializeDecoration(CardType cardType) {
    const double cardCornerRadius = 20;
    const int addIncomeCardAlpha = 127;

    switch (cardType) {
      case CardType.addIncome:
        boxDecoration = BoxDecoration(
          color: Colors.grey.withAlpha(addIncomeCardAlpha),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(addIncomeCardAlpha),
            width: 10,
          ),
        );
        splashColor = ColorPalette.azurSnow.withAlpha(70);
      case CardType.passiveIncome:
        boxDecoration = BoxDecoration(
          color: Colors.blue.withAlpha(addIncomeCardAlpha),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(color: Colors.black.withAlpha(addIncomeCardAlpha), width: 1),
        );
        splashColor = Colors.blue;
      case CardType.savingAccounts:
        boxDecoration = const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(cardCornerRadius)),
        );
        splashColor = Colors.blue;
    }
  }
}
