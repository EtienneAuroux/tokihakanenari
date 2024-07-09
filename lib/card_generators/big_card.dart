import 'dart:math';
// import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/content_creation.dart';
import 'package:tokihakanenari/card_types/index_funds.dart';
import 'package:tokihakanenari/card_types/passive_income.dart';
import 'package:tokihakanenari/card_types/private_funds.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/large_card_clipper.dart';

class BigCard extends StatefulWidget {
  final CardType cardType;
  final Size screenSize;
  final void Function() onPanBigCardCorner;

  const BigCard({
    super.key,
    required this.cardType,
    required this.screenSize,
    required this.onPanBigCardCorner,
  });

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  double flippedDistance = 0;
  Duration? panStartTime;
  bool forwardPageFlipping = false;

  Widget generateBigCard(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        return const AddCard(
          cardStatus: CardStatus.big,
        );
      case CardType.contentCreation:
        return const ContentCreation(
          cardStatus: CardStatus.big,
        );
      case CardType.indexFunds:
        return const IndexFunds(
          cardStatus: CardStatus.big,
        );
      case CardType.passiveIncome:
        return const PassiveIncome(
          cardStatus: CardStatus.big,
        );
      case CardType.privateFunds:
        return const PrivateFunds(
          cardStatus: CardStatus.big,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardStatus: CardStatus.big,
        );
    }
  }

  void pageFlipping(Size size, bool forward, double speed) async {
    if (forward) {
      int time = 1;
      while (flippedDistance < size.width * 3) {
        setState(() {
          flippedDistance += sqrt(speed * time);
        });
        time += 1;
        await Future.delayed(const Duration(milliseconds: 1));
      }
      widget.onPanBigCardCorner();
      forwardPageFlipping = false;
    } else {
      const int animationTime = 200;
      for (int time = 1; time <= animationTime; time++) {
        setState(() {
          flippedDistance = size.width * 3 - sqrt(speed * time);
          if (flippedDistance < 0) {
            flippedDistance = 0;
          }
        });
        if (flippedDistance == 0) {
          return;
        }
        await Future.delayed(const Duration(milliseconds: 1));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    pageFlipping(widget.screenSize, forwardPageFlipping, 6400);
  }

  @override
  Widget build(BuildContext context) {
    double panLimit = sqrt(pow(widget.screenSize.width / 6, 2) + pow(widget.screenSize.height / 6, 2));

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.localPosition.dx < 2 * widget.screenSize.width / 3 && details.localPosition.dy > widget.screenSize.height / 2) {
          panStartTime ??= details.sourceTimeStamp;
          if (flippedDistance > panLimit && !forwardPageFlipping) {
            double userSpeed = panLimit / (details.sourceTimeStamp!.inMilliseconds - panStartTime!.inMilliseconds);
            forwardPageFlipping = true;
            pageFlipping(widget.screenSize, forwardPageFlipping, userSpeed);
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
            clipper: LargeCardContour(
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
