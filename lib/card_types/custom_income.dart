import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  List<Income> customIncomes = <Income>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardType: CardType.customIncome,
          incomes: customIncomes,
          onUpdateItems: () {
            customIncomes = getCustomIncomes();
            if (mounted) {
              setState(() {});
            }
          },
        );
      case CardSize.mini:
        return Center(
          child: Text(
            AppLocalizations.of(context)!.customIncomes,
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return SmallCardContainer(
          cardTitle: AppLocalizations.of(context)!.customIncomes,
          perDay: ledger.customIncomeData.totalPerDay,
          investedAmount: ledger.customIncomeData.totalInvested,
        );
    }
  }

  List<Income> getCustomIncomes() {
    List<Income> customIncomes = <Income>[];
    for (int i = 0; i < ledger.customIncomeData.names.length; i++) {
      customIncomes.add(
        Income(
          ledger.customIncomeData.names[i],
          ledger.customIncomeData.perDay[i],
          icon: ledger.customIncomeData.icons[i],
          amount: ledger.customIncomeData.amounts[i],
          interest: ledger.customIncomeData.interests[i],
          revenue: ledger.customIncomeData.revenues[i],
        ),
      );
    }
    return customIncomes;
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
