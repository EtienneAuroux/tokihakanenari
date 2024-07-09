import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class PrivateFunds extends StatefulWidget {
  final CardStatus cardStatus;

  const PrivateFunds({
    super.key,
    required this.cardStatus,
  });

  @override
  State<PrivateFunds> createState() => _PrivateFundsState();
}

class _PrivateFundsState extends State<PrivateFunds> {
  Widget getCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
      case CardStatus.big:
        return const Center(
          child: Text(
            'Private funds',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardStatus.mini:
        return const Center(
          child: Text(
            'Private funds',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardStatus.small:
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
    return getCardContent(widget.cardStatus);
  }
}
