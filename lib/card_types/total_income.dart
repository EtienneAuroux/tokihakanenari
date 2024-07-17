import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class TotalIncome extends StatefulWidget {
  final CardSize cardSize;

  const TotalIncome({
    super.key,
    required this.cardSize,
  });

  @override
  State<TotalIncome> createState() => _TotalIncomeState();
}

class _TotalIncomeState extends State<TotalIncome> {
  Ledger ledger = Ledger();

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return const Center(
          child: Text(
            'Total income',
            style: TextStyles.cardTitle,
          ),
        );
      case CardSize.mini:
        throw ErrorDescription('TotalIncome should not be used as a mini card.');
      case CardSize.small:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Total income',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.totalIncomeData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.totalIncomeData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
