import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

// import 'dart:developer' as developer;

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
  List<Income> salaries = <Income>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardTitle: 'Salaries',
          itemName: 'salary',
          cardType: CardType.salaries,
          incomes: salaries,
          onUpdateItems: () {
            salaries = getSalaries();
            if (mounted) {
              setState(() {});
            }
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
                '${ledger.salariesData.totalPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              )
            ],
          ),
        );
    }
  }

  List<Income> getSalaries() {
    List<Income> salaries = <Income>[];
    for (int i = 0; i < ledger.salariesData.names.length; i++) {
      salaries.add(
        Income(
          ledger.salariesData.names[i],
          ledger.salariesData.perDay[i],
          icon: ledger.salariesData.icons[i],
          revenue: ledger.salariesData.salaries[i],
          timePeriod: ledger.salariesData.timePeriods[i],
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
