import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class PrivateFunds extends StatefulWidget {
  final CardSize cardSize;

  const PrivateFunds({
    super.key,
    required this.cardSize,
  });

  @override
  State<PrivateFunds> createState() => _PrivateFundsState();
}

class _PrivateFundsState extends State<PrivateFunds> {
  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return const Center(
          child: Text(
            'Private funds',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Private funds',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return const Center(
          child: Text(
            'Private funds',
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
