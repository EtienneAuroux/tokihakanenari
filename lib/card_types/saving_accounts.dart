import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class SavingAccounts extends StatefulWidget {
  final CardSize cardSize;

  const SavingAccounts({
    super.key,
    required this.cardSize,
  });

  @override
  State<SavingAccounts> createState() => _SavingAccountsState();
}

class _SavingAccountsState extends State<SavingAccounts> {
  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return const Center(
          child: Text(
            'Saving accounts',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Saving accounts',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return const Center(
          child: Text(
            'Saving accounts',
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
