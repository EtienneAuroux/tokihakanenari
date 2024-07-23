import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
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
  List<Income> totalIncomes = <Income>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardTitle: 'Total income',
          itemName: '',
          cardType: CardType.totalIncome,
          incomes: totalIncomes,
          onUpdateItems: () {
            totalIncomes = getTotalIncomes();
            if (mounted) {
              setState(() {});
            }
          },
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
                '${ledger.totalIncomeData.totalIncomePerDay.toStringAsFixed(2)} / day',
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

  List<Income> getTotalIncomes() {
    List<Income> totalIncomes = <Income>[];
    for (int i = 0; i < ledger.totalIncomeData.incomesPerDay.length; i++) {
      totalIncomes.add(
        Income(
          ledger.totalIncomeData.incomesType[i].title,
          ledger.totalIncomeData.incomesPerDay[i],
        ),
      );
    }
    return totalIncomes;
  }

  @override
  void initState() {
    super.initState();

    totalIncomes = getTotalIncomes();

    ledger.addListener(() {
      totalIncomes = getTotalIncomes();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    ledger.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
