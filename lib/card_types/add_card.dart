import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/mini_card.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

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
              // Need to prevent this until animation of add card coming in is done.
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const Text(
                'Add Income Source',
                textAlign: TextAlign.center,
                style: TextStyles.bigCardTitle,
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
