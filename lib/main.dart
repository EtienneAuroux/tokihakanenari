import 'package:flutter/material.dart';
import 'package:tokihakanenari/carousel.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/card_generators/custom_card.dart';
import 'package:tokihakanenari/moving_backgrounds/floating_waves.dart';
import 'package:tokihakanenari/my_enums.dart';

import 'dart:developer' as developer;

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
      home: MainPage(
        appTitle: appTitle,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final String appTitle;

  const MainPage({super.key, required this.appTitle});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Color> colors = [
    ColorPalette.ocre,
    ColorPalette.autumnOrange,
  ];

  bool carouselView = true;
  CardType cardToEnlarge = CardType.passiveIncome;

  Widget largeCard(CardType cardType) {
    return CustomCard(
      cardType: cardType,
      cardStatus: CardStatus.big,
      onChangeCardStatus: (CardStatus cardStatus) {
        if (cardStatus == CardStatus.small) {
          setState(() {
            carouselView = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingWaves(
      colors: colors,
      child: carouselView
          ? Carousel(
              onRequestToEnlargeCard: (cardType) {
                setState(() {
                  cardToEnlarge = cardType;
                  carouselView = false;
                });
              },
            )
          : largeCard(cardToEnlarge),
    );
  }
}
