import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/mini_card.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'dart:developer' as developer;

class AddCard extends StatefulWidget {
  final CardSize cardSize;
  final CardStatus cardStatus;
  final void Function(CardType) onRequestToAddCard;

  const AddCard({
    super.key,
    required this.cardSize,
    required this.cardStatus,
    required this.onRequestToAddCard,
  });

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  Ledger ledger = Ledger();
  List<MiniCard> remainingCards = <MiniCard>[];

  List<MiniCard> getRemainingCards() {
    List<MiniCard> remainingCards = <MiniCard>[];
    for (CardType cardType in CardType.values) {
      if (!ledger.carouselCards.contains(cardType)) {
        remainingCards.add(
          MiniCard(
            cardType: cardType,
            onTapMiniCard: () {
              if (widget.cardStatus == CardStatus.inert) {
                widget.onRequestToAddCard(cardType);
              }
            },
          ),
        );
      }
    }
    return remainingCards;
  }

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const Text(
                'Add Income Source',
                textAlign: TextAlign.center,
                style: TextStyles.cardTitle,
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 100,
                ),
                children: remainingCards,
              )
            ],
          ),
        );
      case CardSize.mini:
        throw UnimplementedError('addCard should not be used as a mini card.');
      case CardSize.small:
        return const Center(
          child: Icon(
            Icons.add_rounded,
            size: 100,
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    remainingCards = getRemainingCards();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
