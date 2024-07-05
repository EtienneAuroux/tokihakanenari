import 'package:flutter/material.dart';
import 'package:tokihakanenari/carousel.dart';
import 'package:tokihakanenari/color_palette.dart';
import 'package:tokihakanenari/moving_backgrounds/floating_waves.dart';

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

  @override
  Widget build(BuildContext context) {
    return FloatingWaves(
      colors: colors,
      child: Carousel(
        callback: (cardType) {
          developer.log('user wants ${cardType.name}');
        },
      ),
    );
  }
}
