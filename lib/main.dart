import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_card.dart';
import 'package:tokihakanenari/carousel.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/moving_backgrounds/falling_droplets.dart';
import 'package:tokihakanenari/moving_backgrounds/moving_background.dart';
import 'package:tokihakanenari/my_enums.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:developer' as developer;

import 'package:tokihakanenari/visual_tools/dimensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Ledger().init();
  FlutterView? flutterView = PlatformDispatcher.instance.views.firstOrNull;
  if (flutterView == null || flutterView.physicalSize.isEmpty) {
    PlatformDispatcher.instance.onMetricsChanged = () {
      flutterView = PlatformDispatcher.instance.views.firstOrNull;
      if (flutterView != null && !flutterView!.physicalSize.isEmpty) {
        PlatformDispatcher.instance.onMetricsChanged = null;
        runApp(const Okame());
      }
    };
  } else {
    runApp(const Okame());
  }
}

class Okame extends StatelessWidget {
  const Okame({super.key});
  final String appTitle = 'Okame';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
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
  Ledger ledger = Ledger();
  MainView mainView = MainView.carousel;
  CardType bigCard = CardType.totalIncome;
  CardType newBigCard = CardType.contentCreation;
  late CardStatus cardStatus;

  @override
  void initState() {
    super.initState();

    Dimensions.deviceSize = (context.getElementForInheritedWidgetOfExactType<MediaQuery>()!.widget as MediaQuery).data.size;

    cardStatus = CardStatus.inert;

    ledger.addListener(() {
      if (mounted) {
        setState(() {});
        developer.log('main, listened, ${ledger.backgroundGradient.bottom}');
      }
    });
  }

  @override
  void dispose() {
    ledger.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MovingBackground(
      background: ledger.background,
      colors: [ledger.backgroundGradient.topRight, ledger.backgroundGradient.bottom],
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
          visible: mainView == MainView.primaryBigCard || cardStatus == CardStatus.drop,
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
            onRequestToDropCard: (cardType) {
              setState(() {
                newBigCard = cardType;
                cardStatus = CardStatus.drop;
                mainView = MainView.secondaryBigCard;
              });
            },
            onBigCardDropDone: () {
              throw ErrorDescription('It should not be possible to drop in from MainView.primaryBigCard.');
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
            onRequestToDropCard: (cardType) {
              throw ErrorDescription('It should not be possible to request AddCard from MainView.secondaryBigCard.');
            },
            onBigCardDropDone: () {
              setState(() {
                cardStatus = CardStatus.inert;
              });
            },
          ),
        ),
        IgnorePointer(
          child: Visibility(
            visible: ledger.rainIsOn,
            child: FallingDroplets(),
          ),
        )
      ]),
    );
  }
}


// TODO LOOK AT THIS:
// static Event onMenuVisibilityChanged = Event();
// static set showFilterSettings (bool newValue) {
//     _showFilterSettings = newValue;
//     onMenuVisibilityChanged.broadcast();
//   }
//   static bool get showFilterSettings => _showFilterSettings;
// static bool get showFilterSettings => _showFilterSettings;

// Google Play Console
// okame.developer
// UH27ciTnhud1

// flutter build appbundle --no-tree-shake-icons

// jkr7i1%1jhsDj9

// Tester community: hH37shYw1g
// https://blog.testerscommunity.com/google-play-production-access-after-closedtesting/