import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_content.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class CustomIncome extends StatefulWidget {
  final CardSize cardSize;

  const CustomIncome({
    super.key,
    required this.cardSize,
  });

  @override
  State<CustomIncome> createState() => _CustomIncomeState();
}

class _CustomIncomeState extends State<CustomIncome> {
  Ledger ledger = Ledger();
  List<Row> customIncomes = <Row>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigContent(
          cardTitle: 'Custom incomes',
          itemName: 'custom income',
          cardType: CardType.customIncome,
          cardItems: customIncomes,
          onUpdateItems: () {
            customIncomes = getCustomIncomes();
            if (mounted) {
              setState(() {});
            }
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Custom incomes',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Custom incomes',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.salariesData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              )
            ],
          ),
        );
    }
  }

  List<Row> getCustomIncomes() {
    List<Row> salaries = <Row>[];
    for (int i = 0; i < ledger.salariesData.names.length; i++) {
      salaries.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(ledger.salariesData.icons[i]),
            Flexible(
              child: Text(
                ledger.salariesData.names[i],
                style: TextStyles.cardBody,
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            Text(
              '${ledger.salariesData.salaries[i]} / ${ledger.salariesData.timePeriods[i].name}',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      );
    }
    return salaries;
  }

  @override
  void initState() {
    super.initState();

    customIncomes = getCustomIncomes();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
