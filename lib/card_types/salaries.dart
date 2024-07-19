import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_content.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class Salaries extends StatefulWidget {
  final CardSize cardSize;

  const Salaries({
    super.key,
    required this.cardSize,
  });

  @override
  State<Salaries> createState() => _SalariesState();
}

class _SalariesState extends State<Salaries> {
  Ledger ledger = Ledger();
  List<Row> salaries = <Row>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigContent(
          cardTitle: 'Salaries',
          itemName: 'salary',
          cardType: CardType.salaries,
          cardItems: salaries,
          onUpdateItems: () {
            salaries = getSalaries();
            setState(() {});
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Salaries',
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
                'Salaries',
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

  List<Row> getSalaries() {
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

    salaries = getSalaries();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
