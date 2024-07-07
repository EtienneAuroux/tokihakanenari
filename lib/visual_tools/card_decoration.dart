import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/my_enums.dart';

class CardDecoration {
  static BoxDecoration getDecoration(CardType cardType) {
    const double cardCornerRadius = 20;
    const int addIncomeCardAlpha = 127;

    switch (cardType) {
      case CardType.addIncome:
        return BoxDecoration(
          color: Colors.grey.withAlpha(addIncomeCardAlpha),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(addIncomeCardAlpha),
            width: 10,
          ),
        );
      case CardType.passiveIncome:
        return BoxDecoration(
          color: Colors.blue.withAlpha(addIncomeCardAlpha),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(color: Colors.black.withAlpha(addIncomeCardAlpha), width: 1),
        );
      case CardType.savingAccounts:
        return const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(cardCornerRadius)),
        );
    }
  }

  static Color getSplashColor(CardType cardType) {
    switch (cardType) {
      case CardType.addIncome:
        return ColorPalette.azurSnow.withAlpha(70);
      case CardType.passiveIncome:
        return Colors.blue;
      case CardType.savingAccounts:
        return Colors.blue;
    }
  }
}
