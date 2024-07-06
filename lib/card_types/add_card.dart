import 'package:flutter/material.dart';
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
  Widget setCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
      case CardStatus.mini:
        return const Center(
          child: Text('mini'),
        );
      case CardStatus.small:
        return const Center(
          child: Icon(
            Icons.add_rounded,
            size: 100,
          ),
        );
      case CardStatus.big:
        return const Center(
          child: Icon(
            Icons.remove_rounded,
            size: 100,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return setCardContent(widget.cardStatus);
  }
}
