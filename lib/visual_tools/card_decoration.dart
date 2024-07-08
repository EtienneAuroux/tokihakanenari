import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/my_enums.dart';

class CardDecoration {
  static BoxDecoration getBigCornerDecoration(CardType cardType) {
    switch (cardType) {
      case CardType.addIncome:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.green],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        );
      case CardType.passiveIncome:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown, Colors.grey],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        );
      case CardType.savingAccounts:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.green],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        );
    }
  }

  static BoxDecoration getBigDecoration(CardType cardType) {
    switch (cardType) {
      case CardType.addIncome:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorPalette.mirrorGrey, ColorPalette.mirrorYellow],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
      case CardType.passiveIncome:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.oceanBlue,
              ColorPalette.shallowOcean,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
      case CardType.savingAccounts:
        return BoxDecoration();
    }
  }

  static BoxDecoration getSmallDecoration(CardType cardType) {
    const double cardCornerRadius = 20;
    const int smallCardAlpha = 127;

    switch (cardType) {
      case CardType.addIncome:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorPalette.mirrorGrey.withAlpha(smallCardAlpha), ColorPalette.mirrorYellow.withAlpha(smallCardAlpha)],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(smallCardAlpha),
            width: 10,
          ),
        );
      case CardType.passiveIncome:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.oceanBlue.withAlpha(smallCardAlpha),
              ColorPalette.shallowOcean.withAlpha(smallCardAlpha),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
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
