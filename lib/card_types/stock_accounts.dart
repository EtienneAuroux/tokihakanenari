import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class StockAccounts extends StatefulWidget {
  final CardSize cardSize;

  const StockAccounts({
    super.key,
    required this.cardSize,
  });

  @override
  State<StockAccounts> createState() => _StockAccountsState();
}

class _StockAccountsState extends State<StockAccounts> {
  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return const Center(
          child: Text(
            'Stocks',
            style: TextStyles.bigCardTitle,
          ),
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Stocks',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return const Center(
          child: Text(
            'Stocks',
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
