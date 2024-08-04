import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/color_gradient.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'dart:developer' as developer;

class CardDecoration {
  Ledger ledger = Ledger();

  static BoxDecoration getBigCornerDecoration(CardType cardType) {
    return const BoxDecoration(
        gradient: LinearGradient(
      colors: [ColorPalette.rockDarkGrey, ColorPalette.rockLightGrey],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ));
  }

  static BoxDecoration getBigDecoration(CardType cardType, {bool totalIncome = false}) {
    ColorGradient bigGradient = getGradientColors(cardType, CardSize.big);
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
        colors: [bigGradient.bottom, bigGradient.topRight],
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

  static ColorGradient getGradientColors(CardType cardType, CardSize cardStatus) {
    switch (cardType) {
      case CardType.addCard:
        if (cardStatus == CardSize.big) {
          return Ledger().addCardGradient;
        } else {
          return ColorGradient(ColorPalette.mirrorGrey.withAlpha(127), ColorPalette.mirrorYellow.withAlpha(127));
        }
      case CardType.contentCreation:
        return Ledger().contentCreationData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.customIncome:
        return Ledger().customIncomeData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.indexFunds:
        return Ledger().indexFundsData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.privateFunds:
        return Ledger().privateFundsData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.realEstate:
        return Ledger().realEstateData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.salaries:
        return Ledger().salariesData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.savingAccounts:
        return Ledger().savingAccountsData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.stockAccounts:
        return Ledger().stockAccountsData.gradient.alpha(getColorAlpha(cardStatus));
      case CardType.totalIncome:
        return Ledger().totalIncomeGradient.alpha(getColorAlpha(cardStatus));
      case CardType.settings:
        return ColorGradient(ColorPalette.silkBeige, ColorPalette.silkWhite);
    }
  }

  static BoxDecoration getMiniDecoration(CardType cardType) {
    ColorGradient miniGradient = getGradientColors(cardType, CardSize.mini);
    return BoxDecoration(
        gradient: LinearGradient(
          colors: [miniGradient.bottom, miniGradient.topRight],
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }

  static BoxDecoration getSmallDecoration(CardType cardType) {
    ColorGradient smallGradient = getGradientColors(cardType, CardSize.small);
    return BoxDecoration(
        gradient: LinearGradient(
          colors: [smallGradient.bottom, smallGradient.topRight],
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
