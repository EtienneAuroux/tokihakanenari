import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_card.dart';
import 'package:tokihakanenari/carousel.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/moving_backgrounds/floating_waves.dart';
import 'package:tokihakanenari/my_enums.dart';

import 'dart:developer' as developer;

// import 'dart:developer' as developer;

void main() {
  runApp(const TokiHaKaneNari());
}

class TokiHaKaneNari extends StatelessWidget {
  const TokiHaKaneNari({super.key});

  final String appTitle = '時は金なり';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainView mainView = MainView.carousel;
  CardType bigCard = CardType.passiveIncome;
  CardType newBigCard = CardType.contentCreation;
  late CardStatus cardStatus;

  @override
  void initState() {
    super.initState();

    cardStatus = CardStatus.inert;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return FloatingWaves(
      colors: const [ColorPalette.mirrorYellow, ColorPalette.mirrorGrey],
      child: Stack(children: [
        Carousel(
          cardStatus: cardStatus,
          onRequestBigCard: (cardType) {
            if (mainView == MainView.carousel) {
              setState(() {
                bigCard = cardType;
                cardStatus = CardStatus.unroll;
                mainView = MainView.primaryBigCard;
              });
            }
          },
        ),
        Visibility(
          visible: mainView == MainView.primaryBigCard,
          child: BigCard(
            cardType: bigCard,
            screenSize: screenSize,
            cardStatus: cardStatus,
            onBigCardRollDone: () {
              setState(() {
                cardStatus = CardStatus.inert;
                mainView = MainView.carousel;
              });
            },
            onBigCardUnrollDone: () {
              setState(() {
                cardStatus = CardStatus.inert;
              });
            },
            onRequestToAddCard: (cardType) {
              setState(() {
                newBigCard = cardType;
                mainView = MainView.secondaryBigCard;
              });
            },
          ),
        ),
        Visibility(
          visible: mainView == MainView.secondaryBigCard,
          child: BigCard(
            cardType: newBigCard,
            screenSize: screenSize,
            cardStatus: cardStatus,
            onBigCardRollDone: () {
              setState(() {
                mainView = MainView.carousel;
              });
            },
            onBigCardUnrollDone: () {
              setState(() {
                cardStatus = CardStatus.inert;
              });
            },
            onRequestToAddCard: (cardType) {
              throw ErrorDescription('It should not be possible to request AddCard from MainView.secondaryBigCard.');
            },
          ),
        ),
      ]),
    );
  }
}
