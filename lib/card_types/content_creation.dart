import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ContentCreation extends StatefulWidget {
  final CardStatus cardStatus;

  const ContentCreation({
    super.key,
    required this.cardStatus,
  });

  @override
  State<ContentCreation> createState() => _ContentCreationState();
}

class _ContentCreationState extends State<ContentCreation> {
  Widget getCardContent(CardStatus cardStatus) {
    switch (cardStatus) {
      case CardStatus.big:
        return const Center(
          child: Text(
            'Content creation',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardStatus.mini:
        return const Center(
          child: Text(
            'Content creation',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardStatus.small:
        return const Center(
          child: Text(
            'Content creation',
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
