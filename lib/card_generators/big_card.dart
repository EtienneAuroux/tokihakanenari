import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/content_creation.dart';
import 'package:tokihakanenari/card_types/custom_income.dart';
import 'package:tokihakanenari/card_types/index_funds.dart';
import 'package:tokihakanenari/card_types/settings.dart';
import 'package:tokihakanenari/card_types/total_income.dart';
import 'package:tokihakanenari/card_types/private_funds.dart';
import 'package:tokihakanenari/card_types/real_estate.dart';
import 'package:tokihakanenari/card_types/salaries.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/card_types/stock_accounts.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/big_card_clipper.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';

class BigCard extends StatefulWidget {
  final CardType cardType;
  final Size screenSize;
  final CardStatus cardStatus;
  final void Function() onBigCardRollDone;
  final void Function() onBigCardUnrollDone;
  final void Function(CardType cardType) onRequestToDropCard;
  final void Function() onBigCardDropDone;

  const BigCard({
    super.key,
    required this.cardType,
    required this.screenSize,
    required this.cardStatus,
    required this.onBigCardRollDone,
    required this.onBigCardUnrollDone,
    required this.onRequestToDropCard,
    required this.onBigCardDropDone,
  });

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  Ledger ledger = Ledger();
  double flippedDistance = 0;
  Duration? panStartTime;
  bool droppingIn = false;
  int dropNumber = 0;
  final int numberOfDrops = 300;
  List<List<int>> randoms = [];

  Widget generateBigCard(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        return AddCard(
          cardSize: CardSize.big,
          cardStatus: widget.cardStatus,
          onRequestToAddCard: (CardType cardType) {
            widget.onRequestToDropCard(cardType);
          },
        );
      case CardType.contentCreation:
        return const ContentCreation(
          cardSize: CardSize.big,
        );
      case CardType.customIncome:
        return const CustomIncome(
          cardSize: CardSize.big,
        );
      case CardType.indexFunds:
        return const IndexFunds(
          cardSize: CardSize.big,
        );
      case CardType.privateFunds:
        return const PrivateFunds(
          cardSize: CardSize.big,
        );
      case CardType.realEstate:
        return const RealEstate(
          cardSize: CardSize.big,
        );
      case CardType.salaries:
        return const Salaries(
          cardSize: CardSize.big,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardSize: CardSize.big,
        );
      case CardType.stockAccounts:
        return const StockAccounts(
          cardSize: CardSize.big,
        );
      case CardType.totalIncome:
        return TotalIncome(
          cardSize: CardSize.big,
          onRequestSettings: () {
            widget.onRequestToDropCard(CardType.settings);
          },
        );
      case CardType.settings:
        return const Settings();
    }
  }

  void pageFlipping(Size size, CardStatus cardStatus, double speed) async {
    if (cardStatus == CardStatus.roll) {
      int time = 0;
      while (flippedDistance < Dimensions.maxFlippingDistance) {
        setState(() {
          flippedDistance += speed * time;
        });
        time += 1;
        await Future.delayed(const Duration(milliseconds: 1));
      }
      widget.onBigCardRollDone();
    } else if (cardStatus == CardStatus.unroll) {
      int time = 1;
      while (flippedDistance >= 0) {
        flippedDistance = Dimensions.maxFlippingDistance - speed * time * 0.001;
        if (flippedDistance > 0) {
          setState(() {});
        }
        await Future.delayed(const Duration(milliseconds: 1));
        time += 1;
      }
      if (flippedDistance < 0) {
        setState(() {
          flippedDistance = 0;
        });
      }
      if (flippedDistance == 0) {
        widget.onBigCardUnrollDone();
        return;
      }
    }
  }

  void cardDropping() async {
    Random random = Random();
    setState(() {
      droppingIn = true;
      randoms = List.generate(numberOfDrops, (index) => [random.nextInt(numberOfDrops), random.nextInt(numberOfDrops)]);
    });

    for (int time = 0; time < numberOfDrops; time++) {
      setState(() {
        dropNumber += 1;
      });
      await Future.delayed(const Duration(milliseconds: 1));
    }
    setState(() {
      droppingIn = false;
    });
    ledger.startTapIndicator = true;
    widget.onBigCardDropDone();
  }

  @override
  void initState() {
    super.initState();

    if (widget.cardStatus == CardStatus.unroll) {
      pageFlipping(widget.screenSize, CardStatus.unroll, Dimensions.pageUnrollingSpeed);
    } else if (widget.cardStatus == CardStatus.drop) {
      cardDropping();
    }
  }

  int previousTime = DateTime.now().millisecondsSinceEpoch;
  double userSpeed = 0;
  @override
  Widget build(BuildContext context) {
    double panLimit = sqrt(pow(widget.screenSize.width / 6, 2) + pow(widget.screenSize.height / 6, 2));
    return GestureDetector(
      onPanUpdate: (details) {
        if (widget.cardStatus == CardStatus.inert &&
            details.localPosition.dx < 2 * widget.screenSize.width / 3 &&
            details.localPosition.dy > widget.screenSize.height / 2) {
          panStartTime ??= details.sourceTimeStamp;
          if (flippedDistance >= panLimit) {
            pageFlipping(widget.screenSize, CardStatus.roll, userSpeed);
          } else {
            int newTime = DateTime.now().millisecondsSinceEpoch;
            userSpeed = details.delta.distance / (newTime - previousTime) / 10;
            previousTime = newTime;
            setState(() {
              flippedDistance += details.delta.distance;
            });
          }
        }
      },
      onPanEnd: (details) {
        if (flippedDistance <= panLimit) {
          setState(() {
            flippedDistance = 0;
          });
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipPath(
            clipper: BigCardContour(
              flippedDistance: flippedDistance,
              droppingIn: droppingIn,
              numberOfDrops: numberOfDrops,
              dropNumber: dropNumber,
              randoms: randoms,
            ),
            child: Container(
              decoration: CardDecoration.getBigDecoration(widget.cardType),
              child: generateBigCard(widget.cardType),
            ),
          ),
          ClipPath(
            clipper: FlippedCornerContour(
              flippedDistance: flippedDistance,
            ),
            child: Container(
              decoration: CardDecoration.getBigCornerDecoration(widget.cardType),
            ),
          )
        ],
      ),
    );
  }
}
