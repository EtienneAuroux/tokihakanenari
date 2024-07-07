import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/passive_income.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/large_card_clipper.dart';

import 'dart:developer' as developer;

class BigCard extends StatefulWidget {
  final CardType cardType;
  final void Function() onPanBigCardCorner;

  const BigCard({
    super.key,
    required this.cardType,
    required this.onPanBigCardCorner,
  });

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  double flippedDistance = 0;

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

  @override
  Widget build(BuildContext context) {
    Size bigCardSize = MediaQuery.of(context).size;
    double panLimit = sqrt(pow(bigCardSize.width / 6, 2) + pow(bigCardSize.height / 6, 2));

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.localPosition.dx < bigCardSize.width / 2 && details.localPosition.dy > bigCardSize.height / 2) {
          setState(() {
            flippedDistance += details.delta.distance;
          });
          if (flippedDistance > panLimit) {
            widget.onPanBigCardCorner();
          }
        }
      },
      onPanEnd: (details) {
        // Here flipped distance should go back to 0 slowly.
        setState(() {
          flippedDistance = 0;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ClipPath(
          //   clipper: LargeCardContour(
          //     flippedCornerLength: 100 + flippedDistance,
          //   ),
          //   child: Container(
          //     decoration: CardDecoration.getDecoration(widget.cardType),
          //     child: generateBigCard(widget.cardType),
          //   ),
          // ),
          ClipPath(
            clipper: FlippedCornerContour(
              flippedDistance: flippedDistance,
            ),
            child: Container(
              decoration: CardDecoration.getCornerDecoration(widget.cardType),
            ),
          )
        ],
      ),
    );
  }
}
