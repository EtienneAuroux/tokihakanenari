import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/my_enums.dart';

class CardDecoration {
  static BoxDecoration getBigCornerDecoration(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorPalette.spaceBlue, ColorPalette.spaceGrey],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        );
      case CardType.contentCreation:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.green],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        );
      case CardType.indexFunds:
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
            colors: [ColorPalette.spaceBlue, ColorPalette.spaceGrey],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        );
      case CardType.privateFunds:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.green],
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
    return BoxDecoration(
      gradient: LinearGradient(
        colors: getGradientColors(cardType, CardStatus.big),
        begin: Alignment.bottomCenter,
        end: Alignment.topRight,
      ),
    );
  }

  static int getColorAlpha(CardStatus cardStatus) {
    if (cardStatus == CardStatus.small) {
      return 127;
    } else {
      return 255;
    }
  }

  static List<Color> getGradientColors(CardType cardType, CardStatus cardStatus) {
    switch (cardType) {
      case CardType.addCard:
        if (cardStatus == CardStatus.big) {
          return [ColorPalette.silkBeige, ColorPalette.silkWhite];
        } else {
          return [ColorPalette.mirrorGrey.withAlpha(getColorAlpha(cardStatus)), ColorPalette.mirrorYellow.withAlpha(getColorAlpha(cardStatus))];
        }
      case CardType.contentCreation:
        return [ColorPalette.sanguineRed.withAlpha(getColorAlpha(cardStatus)), ColorPalette.sanguineOrange.withAlpha(getColorAlpha(cardStatus))];
      case CardType.indexFunds:
        return [ColorPalette.pigletPink.withAlpha(getColorAlpha(cardStatus)), ColorPalette.pigletPale.withAlpha(getColorAlpha(cardStatus))];
      case CardType.passiveIncome:
        return [ColorPalette.oceanBlue.withAlpha(getColorAlpha(cardStatus)), ColorPalette.oceanOpal.withAlpha(getColorAlpha(cardStatus))];
      case CardType.privateFunds:
        return [ColorPalette.lusciousGreen.withAlpha(getColorAlpha(cardStatus)), ColorPalette.lusciousYellow.withAlpha(getColorAlpha(cardStatus))];
      case CardType.savingAccounts:
        return [ColorPalette.rockDarkGrey.withAlpha(getColorAlpha(cardStatus)), ColorPalette.rockLightGrey.withAlpha(getColorAlpha(cardStatus))];
    }
  }

  static BoxDecoration getMiniDecoration(CardType cardType) {
    return BoxDecoration(
        gradient: LinearGradient(
          colors: getGradientColors(cardType, CardStatus.mini),
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }

  static BoxDecoration getSmallDecoration(CardType cardType) {
    return BoxDecoration(
        gradient: LinearGradient(
          colors: getGradientColors(cardType, CardStatus.small),
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)));
  }

  static Color getSplashColor(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        return ColorPalette.mirrorYellow.withAlpha(127);
      case CardType.contentCreation:
        return ColorPalette.sanguineOrange.withAlpha(127);
      case CardType.indexFunds:
        return ColorPalette.pigletPale.withAlpha(127);
      case CardType.passiveIncome:
        return ColorPalette.oceanOpal.withAlpha(127);
      case CardType.privateFunds:
        return ColorPalette.lusciousYellow.withAlpha(127);
      case CardType.savingAccounts:
        return ColorPalette.rockLightGrey.withAlpha(127);
    }
  }
}
