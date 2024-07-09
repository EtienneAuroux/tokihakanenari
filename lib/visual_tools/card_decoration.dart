import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/my_enums.dart';

class CardDecoration {
  static const int _smallCardAlpha = 127;

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
            colors: [Colors.brown, Colors.grey],
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
    switch (cardType) {
      case CardType.addIncome:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.mirrorGrey,
              ColorPalette.mirrorYellow,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
      case CardType.contentCreation:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.sanguineRed,
              ColorPalette.sanguineOrange,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
      case CardType.indexFunds:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.pigletPink,
              ColorPalette.pigletPale,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
      case CardType.passiveIncome:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.oceanBlue,
              ColorPalette.oceanOpal,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
      case CardType.privateFunds:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.lusciousGreen,
              ColorPalette.lusciousYellow,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
      case CardType.savingAccounts:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.rockDarkGrey,
              ColorPalette.rockLightGrey,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        );
    }
  }

  static BoxDecoration getSmallDecoration(CardType cardType) {
    const double cardCornerRadius = 20;

    switch (cardType) {
      case CardType.addIncome:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.mirrorGrey.withAlpha(_smallCardAlpha),
              ColorPalette.mirrorYellow.withAlpha(_smallCardAlpha),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(_smallCardAlpha),
            width: 10,
          ),
        );
      case CardType.contentCreation:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.sanguineRed.withAlpha(_smallCardAlpha),
              ColorPalette.sanguineOrange.withAlpha(_smallCardAlpha),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(_smallCardAlpha),
            width: 10,
          ),
        );
      case CardType.indexFunds:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.pigletPink.withAlpha(_smallCardAlpha),
              ColorPalette.pigletPale.withAlpha(_smallCardAlpha),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(_smallCardAlpha),
            width: 10,
          ),
        );
      case CardType.passiveIncome:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.oceanBlue.withAlpha(_smallCardAlpha),
              ColorPalette.oceanOpal.withAlpha(_smallCardAlpha),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
        );
      case CardType.privateFunds:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.lusciousGreen.withAlpha(_smallCardAlpha),
              ColorPalette.lusciousYellow.withAlpha(_smallCardAlpha),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(_smallCardAlpha),
            width: 10,
          ),
        );
      case CardType.savingAccounts:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.rockDarkGrey.withAlpha(_smallCardAlpha),
              ColorPalette.rockLightGrey.withAlpha(_smallCardAlpha),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(_smallCardAlpha),
            width: 10,
          ),
        );
    }
  }

  static Color getSplashColor(CardType cardType) {
    switch (cardType) {
      case CardType.addIncome:
        return ColorPalette.mirrorYellow.withAlpha(_smallCardAlpha);
      case CardType.contentCreation:
        return ColorPalette.sanguineOrange.withAlpha(_smallCardAlpha);
      case CardType.indexFunds:
        return ColorPalette.lusciousYellow.withAlpha(_smallCardAlpha);
      case CardType.passiveIncome:
        return ColorPalette.oceanOpal.withAlpha(_smallCardAlpha);
      case CardType.privateFunds:
        return ColorPalette.pigletPale.withAlpha(_smallCardAlpha);
      case CardType.savingAccounts:
        return ColorPalette.rockLightGrey.withAlpha(_smallCardAlpha);
    }
  }
}
