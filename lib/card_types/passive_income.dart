import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class PassiveIncome extends StatefulWidget {
  final CardStatus cardStatus;

  const PassiveIncome({
    super.key,
    required this.cardStatus,
  });

  @override
  State<PassiveIncome> createState() => _PassiveIncomeState();
}

class _PassiveIncomeState extends State<PassiveIncome> {
  Widget getCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
      case CardStatus.big:
        return const Center(
          child: Text(
            'Passive income',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardStatus.mini:
        throw UnimplementedError('addCard should not be used as a mini card.');
      case CardStatus.small:
        return const Center(
          child: Text(
            'Passive income',
            style: TextStyles.smallCardTitle,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardStatus);
  }
}
