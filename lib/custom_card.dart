import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final CardType cardType;
  final Widget cardContent;

  const CustomCard({super.key, required this.cardType, required this.cardContent});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

var test = const RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  side: BorderSide(color: Colors.grey, width: 5),
);

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  Size cardSize(Size deviceSize, Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.landscape) {
      return Size(deviceSize.width * 0.6, deviceSize.height * 0.8);
    } else {
      return Size(deviceSize.width * 0.8, deviceSize.height * 0.6);
    }
  }

  BoxDecoration cardDecoration(CardType cardType) {
    const double cardCornerRadius = 20;
    const int addIncomeCardAlpha = 127;

    switch (cardType) {
      case CardType.addIncome:
        return BoxDecoration(
          color: Colors.grey.withAlpha(addIncomeCardAlpha),
          borderRadius: const BorderRadius.all(Radius.circular(cardCornerRadius)),
          border: Border.all(
            color: Colors.black.withAlpha(addIncomeCardAlpha),
            width: 10,
          ),
        );
      case CardType.passiveIncome:
        return const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(cardCornerRadius)),
        );
      case CardType.savingAccounts:
        return const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(cardCornerRadius)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    Size deviceSize = queryData.size;
    Orientation deviceOrientation = queryData.orientation;

    return Container(
      alignment: Alignment.center,
      child: Container(
        decoration: cardDecoration(widget.cardType),
        width: cardSize(deviceSize, deviceOrientation).width,
        height: cardSize(deviceSize, deviceOrientation).height,
        child: widget.cardContent,
      ),
    );
  }
}

enum CardType { passiveIncome, savingAccounts, addIncome }
