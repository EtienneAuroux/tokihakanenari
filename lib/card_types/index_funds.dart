import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class IndexFunds extends StatefulWidget {
  final CardStatus cardStatus;

  const IndexFunds({
    super.key,
    required this.cardStatus,
  });

  @override
  State<IndexFunds> createState() => _IndexFundsState();
}

class _IndexFundsState extends State<IndexFunds> {
  Widget getCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
      case CardStatus.big:
        return const Center(
          child: Text(
            'Index funds',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardStatus.mini:
        return const Center(
          child: Text(
            'Index funds',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardStatus.small:
        return const Center(
          child: Text(
            'Index funds',
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
