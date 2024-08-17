import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'dart:developer' as developer;

class TotalIncome extends StatefulWidget {
  final CardSize cardSize;
  final void Function()? onRequestSettings;

  const TotalIncome({
    super.key,
    required this.cardSize,
    this.onRequestSettings,
  });

  @override
  State<TotalIncome> createState() => _TotalIncomeState();
}

class _TotalIncomeState extends State<TotalIncome> {
  Ledger ledger = Ledger();
  List<Income> totalIncomes = <Income>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardType: CardType.totalIncome,
          incomes: getTotalIncomes(),
          onUpdateItems: () {
            if (mounted) {
              setState(() {});
            }
          },
          onRequestSettings: () {
            widget.onRequestSettings?.call();
          },
        );
      case CardSize.mini:
        throw ErrorDescription('TotalIncome should not be used as a mini card.');
      case CardSize.small:
        return SmallCardContainer(
          cardTitle: AppLocalizations.of(context)!.totalIncome,
          perDay: ledger.totalIncomeData.totalIncomePerDay,
          investedAmount: ledger.totalIncomeData.totalInvested,
        );
    }
  }

  List<Income> getTotalIncomes() {
    List<Income> totalIncomes = <Income>[];
    for (int i = 0; i < ledger.totalIncomeData.incomesPerDay.length; i++) {
      totalIncomes.add(
        Income(
          ledger.totalIncomeData.incomesType[i].title(context), // No context in initstate so cannot access localization.
          ledger.totalIncomeData.incomesPerDay[i],
          subIncomeCardType: ledger.totalIncomeData.incomesType[i],
        ),
      );
    }
    return totalIncomes;
  }

  @override
  void initState() {
    super.initState();

    ledger.addListener(() {
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
