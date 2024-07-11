import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class PassiveIncome extends StatefulWidget {
  final CardSize cardSize;

  const PassiveIncome({
    super.key,
    required this.cardSize,
  });

  @override
  State<PassiveIncome> createState() => _PassiveIncomeState();
}

class _PassiveIncomeState extends State<PassiveIncome> {
  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return const Center(
          child: Text(
            'Passive income',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardSize.mini:
        throw UnimplementedError('addCard should not be used as a mini card.');
      case CardSize.small:
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
    return getCardContent(widget.cardSize);
  }
}
