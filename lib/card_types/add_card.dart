import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/mini_card.dart';
import 'package:tokihakanenari/my_enums.dart';

class AddCard extends StatefulWidget {
  final CardStatus cardStatus;
  final void Function(CardType) onRequestToAddCard;

  const AddCard({
    super.key,
    required this.cardStatus,
    required this.onRequestToAddCard,
  });

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  List<MiniCard> remainingCards = <MiniCard>[];

  List<MiniCard> initializeRemainingCards() {
    for (CardType cardType in CardType.values) {
      if (cardType != CardType.addCard && cardType != CardType.passiveIncome) {
        remainingCards.add(
          MiniCard(
            cardType: cardType,
            onTapMiniCard: () {
              widget.onRequestToAddCard(cardType);
            },
          ),
        );
      }
    }
    return remainingCards;
  }

  Widget getCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
      case CardStatus.big:
        return GridView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 100,
          ),
          children: remainingCards,
        );
      case CardStatus.mini:
        throw UnimplementedError('addCard should not be used as a mini card.');
      case CardStatus.small:
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

    if (widget.cardStatus == CardStatus.big) {
      initializeRemainingCards();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardStatus);
  }
}
