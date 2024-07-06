import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/add_income.dart';
import 'package:tokihakanenari/card_decoration.dart';
import 'package:tokihakanenari/passive_income.dart';
import 'package:tokihakanenari/saving_accounts.dart';

class CustomCard extends StatefulWidget {
  final CardType cardType;
  final CardStatus cardStatus;
  final Function(CardStatus) onChangeCardStatus;

  const CustomCard({
    super.key,
    required this.cardType,
    required this.cardStatus,
    required this.onChangeCardStatus,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  late CardDecoration cardDecoration;

  Size cardSize(Size deviceSize, Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.landscape) {
      return Size(deviceSize.width * 0.6, deviceSize.height * 0.8);
    } else {
      return Size(deviceSize.width * 0.8, deviceSize.height * 0.6);
    }
  }

  Widget generateCard(CardType cardType) {
    switch (cardType) {
      case CardType.passiveIncome:
        return const PassiveIncome();
      case CardType.addIncome:
        return AddIncome(
          cardStatus: widget.cardStatus,
        );
      case CardType.savingAccounts:
        return const SavingAccounts();
    }
  }

  @override
  void initState() {
    super.initState();

    cardDecoration = CardDecoration(widget.cardType);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    Size deviceSize = queryData.size;
    Orientation deviceOrientation = queryData.orientation;

    return Container(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: cardDecoration.boxDecoration,
          width: cardSize(deviceSize, deviceOrientation).width,
          height: cardSize(deviceSize, deviceOrientation).height,
          child: InkWell(
            splashColor: cardDecoration.splashColor,
            onLongPress: () {
              developer.log('longpress');
            },
            onTap: () {
              if (widget.cardStatus == CardStatus.small) {
                widget.onChangeCardStatus(CardStatus.big);
              } else if (widget.cardStatus == CardStatus.big) {
                widget.onChangeCardStatus(CardStatus.small);
              }
            },
            child: generateCard(widget.cardType),
          ),
        ),
      ),
    );
  }
}

enum CardStatus { small, big }
