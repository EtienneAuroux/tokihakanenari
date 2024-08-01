import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/my_enums.dart';

class CardDecoration {
  static BoxDecoration getBigCornerDecoration(CardType cardType) {
    return const BoxDecoration(
        gradient: LinearGradient(
      colors: [ColorPalette.rockDarkGrey, ColorPalette.rockLightGrey],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ));
  }

  static BoxDecoration getBigDecoration(CardType cardType, {bool totalIncome = false}) {
    return BoxDecoration(
      borderRadius: totalIncome ? BorderRadius.circular(10) : null,
      border: totalIncome
          ? Border(
              bottom: BorderSide(
                color: Colors.black.withAlpha(50),
                width: 4,
              ),
              right: BorderSide(
                color: Colors.black.withAlpha(50),
                width: 4,
              ),
            )
          : null,
      gradient: LinearGradient(
        colors: getGradientColors(cardType, CardSize.big),
        begin: Alignment.bottomCenter,
        end: Alignment.topRight,
      ),
    );
  }

  static int getColorAlpha(CardSize cardStatus) {
    if (cardStatus == CardSize.small) {
      return 127;
    } else {
      return 255;
    }
  }

  static List<Color> getGradientColors(CardType cardType, CardSize cardStatus) {
    switch (cardType) {
      case CardType.addCard:
        if (cardStatus == CardSize.big) {
          return [ColorPalette.silkBeige, ColorPalette.silkWhite];
        } else {
          return [ColorPalette.mirrorGrey.withAlpha(getColorAlpha(cardStatus)), ColorPalette.mirrorYellow.withAlpha(getColorAlpha(cardStatus))];
        }
      case CardType.contentCreation:
        return [ColorPalette.sanguineRed.withAlpha(getColorAlpha(cardStatus)), ColorPalette.sanguineOrange.withAlpha(getColorAlpha(cardStatus))];
      case CardType.customIncome:
        return [ColorPalette.sunOrange.withAlpha(getColorAlpha(cardStatus)), ColorPalette.sunYellow..withAlpha(getColorAlpha(cardStatus))];
      case CardType.indexFunds:
        return [ColorPalette.pigletPink.withAlpha(getColorAlpha(cardStatus)), ColorPalette.pigletPale.withAlpha(getColorAlpha(cardStatus))];
      case CardType.privateFunds:
        return [ColorPalette.lusciousGreen.withAlpha(getColorAlpha(cardStatus)), ColorPalette.lusciousYellow.withAlpha(getColorAlpha(cardStatus))];
      case CardType.realEstate:
        return [ColorPalette.bleachedGreen.withAlpha(getColorAlpha(cardStatus)), ColorPalette.bleachedOrange.withAlpha(getColorAlpha(cardStatus))];
      case CardType.salaries:
        return [ColorPalette.orbitPurple.withAlpha(getColorAlpha(cardStatus)), ColorPalette.orbitGreen.withAlpha(getColorAlpha(cardStatus))];
      case CardType.savingAccounts:
        return [ColorPalette.exoticPink.withAlpha(getColorAlpha(cardStatus)), ColorPalette.exoticOrange.withAlpha(getColorAlpha(cardStatus))];
      case CardType.stockAccounts:
        return [ColorPalette.toxicYellow.withAlpha(getColorAlpha(cardStatus)), ColorPalette.toxicBlue.withAlpha(getColorAlpha(cardStatus))];
      case CardType.totalIncome:
        return [ColorPalette.oceanBlue.withAlpha(getColorAlpha(cardStatus)), ColorPalette.oceanOpal.withAlpha(getColorAlpha(cardStatus))];
      case CardType.settings:
        throw ErrorDescription('not implemented'); // TODO IMPLEMENT.
    }
  }

  static BoxDecoration getMiniDecoration(CardType cardType) {
    return BoxDecoration(
        gradient: LinearGradient(
          colors: getGradientColors(cardType, CardSize.mini),
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }

  static BoxDecoration getSmallDecoration(CardType cardType) {
    return BoxDecoration(
        gradient: LinearGradient(
          colors: getGradientColors(cardType, CardSize.small),
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
      case CardType.customIncome:
        return ColorPalette.sunYellow.withAlpha(127);
      case CardType.indexFunds:
        return ColorPalette.pigletPale.withAlpha(127);
      case CardType.privateFunds:
        return ColorPalette.lusciousYellow.withAlpha(127);
      case CardType.realEstate:
        return ColorPalette.bleachedOrange.withAlpha(127);
      case CardType.salaries:
        return ColorPalette.orbitGreen.withAlpha(127);
      case CardType.savingAccounts:
        return ColorPalette.exoticOrange.withAlpha(127);
      case CardType.stockAccounts:
        return ColorPalette.toxicBlue.withAlpha(127);
      case CardType.totalIncome:
        return ColorPalette.oceanOpal.withAlpha(127);
      case CardType.settings:
        throw ErrorDescription('There should be no small card Settings, therefore no need for a Settings splash color.');
    }
  }
}
