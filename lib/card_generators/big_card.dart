import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/content_creation.dart';
import 'package:tokihakanenari/card_types/index_funds.dart';
import 'package:tokihakanenari/card_types/passive_income.dart';
import 'package:tokihakanenari/card_types/private_funds.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/big_card_clipper.dart';

class BigCard extends StatefulWidget {
  final CardType cardType;
  final Size screenSize;
  final CardStatus cardStatus;
  final void Function() onBigCardRollDone;
  final void Function() onBigCardUnrollDone;
  final void Function(CardType cardType) onRequestToAddCard;

  const BigCard({
    super.key,
    required this.cardType,
    required this.screenSize,
    required this.cardStatus,
    required this.onBigCardRollDone,
    required this.onBigCardUnrollDone,
    required this.onRequestToAddCard,
  });

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  double flippedDistance = 0;
  Duration? panStartTime;

  Widget generateBigCard(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        return AddCard(
          cardSize: CardSize.big,
          cardStatus: widget.cardStatus,
          onRequestToAddCard: (CardType cardType) {
            widget.onRequestToAddCard(cardType);
          },
        );
      case CardType.contentCreation:
        return const ContentCreation(
          cardSize: CardSize.big,
        );
      case CardType.indexFunds:
        return const IndexFunds(
          cardSize: CardSize.big,
        );
      case CardType.passiveIncome:
        return const PassiveIncome(
          cardSize: CardSize.big,
        );
      case CardType.privateFunds:
        return const PrivateFunds(
          cardSize: CardSize.big,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardSize: CardSize.big,
        );
    }
  }

  void pageFlipping(Size size, CardStatus cardStatus, double speed) async {
    if (cardStatus == CardStatus.roll) {
      int time = 0;
      while (flippedDistance < size.width * 3) {
        setState(() {
          flippedDistance += speed * (1 + time * 0.01);
        });
        time += 1;
        await Future.delayed(const Duration(milliseconds: 1));
      }
      widget.onBigCardRollDone();
    } else if (cardStatus == CardStatus.unroll) {
      const int animationTime = 200;
      for (int time = 1; time <= animationTime; time++) {
        setState(() {
          flippedDistance = size.width * 3 - sqrt(speed * time);
          if (flippedDistance < 0) {
            flippedDistance = 0;
          }
        });
        if (flippedDistance == 0) {
          widget.onBigCardUnrollDone();
          return;
        }
        await Future.delayed(const Duration(milliseconds: 1));
      }
    }
  }

  void cardFadeIn() async {
    developer.log('fade');
  }

  @override
  void initState() {
    super.initState();

    if (widget.cardStatus == CardStatus.unroll) {
      pageFlipping(widget.screenSize, CardStatus.unroll, 6400);
    } else if (widget.cardStatus == CardStatus.fade) {
      cardFadeIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    double panLimit = sqrt(pow(widget.screenSize.width / 6, 2) + pow(widget.screenSize.height / 6, 2));
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.localPosition.dx < 2 * widget.screenSize.width / 3 && details.localPosition.dy > widget.screenSize.height / 2) {
          panStartTime ??= details.sourceTimeStamp;
          if (flippedDistance >= panLimit && widget.cardStatus == CardStatus.inert) {
            double userSpeed = sqrt(1000 * details.delta.distance / (details.sourceTimeStamp!.inMilliseconds - panStartTime!.inMilliseconds));
            pageFlipping(widget.screenSize, CardStatus.roll, userSpeed);
          } else {
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
