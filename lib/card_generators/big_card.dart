import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/passive_income.dart';
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
  bool userTriggerForwardFlip = false;

  Widget generateBigCard(CardType cardType) {
    switch (cardType) {
      case CardType.passiveIncome:
        return const PassiveIncome(
          cardStatus: CardStatus.big,
        );
      case CardType.addIncome:
        return const AddCard(
          cardStatus: CardStatus.big,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardStatus: CardStatus.big,
        );
    }
  }

  void forwardPageFlipping(Size size) async {
    while (flippedDistance < size.width * 3) {
      setState(() {
        flippedDistance += 4;
      });
      await Future.delayed(const Duration(milliseconds: 1));
    }
    widget.onPanBigCardCorner();
    userTriggerForwardFlip = false;
  }

  void backwardPageFlipping(Size size) async {
    setState(() {
      flippedDistance = size.width * 3;
    });
    while (flippedDistance > 0) {
      setState(() {
        if (flippedDistance - 4 < 0) {
          flippedDistance = 0;
        } else {
          flippedDistance -= 4;
        }
      });
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  @override
  void initState() {
    super.initState();

    backwardPageFlipping(widget.screenSize);
  }

  @override
  Widget build(BuildContext context) {
    double panLimit = sqrt(pow(widget.screenSize.width / 6, 2) + pow(widget.screenSize.height / 6, 2));

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.localPosition.dx < 2 * widget.screenSize.width / 3 && details.localPosition.dy > widget.screenSize.height / 2) {
          setState(() {
            flippedDistance += details.delta.distance;
          });
          if (flippedDistance > panLimit && !userTriggerForwardFlip) {
            userTriggerForwardFlip = true;
            forwardPageFlipping(widget.screenSize);
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
