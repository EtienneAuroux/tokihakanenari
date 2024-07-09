import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/mini_card.dart';
import 'package:tokihakanenari/my_enums.dart';

class AddCard extends StatefulWidget {
  final CardStatus cardStatus;

  const AddCard({
    super.key,
    required this.cardStatus,
  });

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  List<MiniCard> remainingCards = [
    MiniCard(cardType: CardType.savingAccounts),
    MiniCard(cardType: CardType.privateFunds),
    MiniCard(cardType: CardType.indexFunds),
    MiniCard(cardType: CardType.contentCreation),
  ];

  Widget setCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
      case CardStatus.mini:
        throw UnimplementedError('addCard should not be used as a mini card.');
      case CardStatus.small:
        return const Center(
          child: Icon(
            Icons.add_rounded,
            size: 100,
          ),
        );
      case CardStatus.big:
        return GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: remainingCards,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return setCardContent(widget.cardStatus);
  }
}
