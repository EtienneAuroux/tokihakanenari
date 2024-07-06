import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_card.dart';
import 'package:tokihakanenari/card_generators/mini_card.dart';
import 'package:tokihakanenari/card_generators/small_card.dart';
import 'package:tokihakanenari/my_enums.dart';

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
  Widget generateCard(CardStatus cardStatus, CardType cardType) {
    switch (cardStatus) {
      case CardStatus.mini:
        return MiniCard(cardType: cardType);
      case CardStatus.small:
        return SmallCard(
          cardType: cardType,
          onTapSmallCard: () {
            widget.onChangeCardStatus(CardStatus.big);
          },
          onLongPressSmallCard: () {},
        );
      case CardStatus.big:
        return BigCard(cardType: cardType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return generateCard(widget.cardStatus, widget.cardType);
  }
}
