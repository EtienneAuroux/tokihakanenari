import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ContentCreation extends StatefulWidget {
  final CardSize cardSize;

  const ContentCreation({
    super.key,
    required this.cardSize,
  });

  @override
  State<ContentCreation> createState() => _ContentCreationState();
}

class _ContentCreationState extends State<ContentCreation> {
  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return const Center(
          child: Text(
            'Content creation',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Content creation',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
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
    return getCardContent(widget.cardSize);
  }
}
