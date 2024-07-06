import 'package:flutter/material.dart';
import 'package:tokihakanenari/custom_card.dart';

class AddIncome extends StatefulWidget {
  final CardStatus cardStatus;

  const AddIncome({
    super.key,
    required this.cardStatus,
  });

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  Widget setCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
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
