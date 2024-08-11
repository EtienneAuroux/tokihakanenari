import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

// import 'dart:developer' as developer;

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
  Ledger ledger = Ledger();
  List<Income> savingAccounts = <Income>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardType: CardType.savingAccounts,
          incomes: savingAccounts,
          onUpdateItems: () {
            savingAccounts = getSavingAccounts();
            if (mounted) {
              setState(() {});
            }
          },
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
        return SmallCardContainer(
          cardTitle: 'Saving accounts',
          perDay: ledger.savingAccountsData.totalPerDay,
          investedAmount: ledger.savingAccountsData.totalInvested,
        );
    }
  }

  List<Income> getSavingAccounts() {
    List<Income> savingAccounts = <Income>[];
    for (int i = 0; i < ledger.savingAccountsData.names.length; i++) {
      savingAccounts.add(
        Income(
          ledger.savingAccountsData.names[i],
          ledger.savingAccountsData.perDay[i],
          icon: ledger.savingAccountsData.icons[i],
          amount: ledger.savingAccountsData.amounts[i],
          interest: ledger.savingAccountsData.ratesOfReturn[i],
        ),
      );
    }
    return savingAccounts;
  }

  @override
  void initState() {
    super.initState();

    savingAccounts = getSavingAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
