import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
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
  Ledger ledger = Ledger();
  List<Income> stockAccounts = <Income>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardType: CardType.stockAccounts,
          incomes: stockAccounts,
          onUpdateItems: () {
            stockAccounts = getStockAccounts();
            if (mounted) {
              setState(() {});
            }
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Stock accounts',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return SmallCardContainer(
          cardTitle: 'Stock accounts',
          perDay: ledger.stockAccountsData.totalPerDay,
          investedAmount: ledger.stockAccountsData.totalInvested,
        );
    }
  }

  List<Income> getStockAccounts() {
    List<Income> stockAccounts = <Income>[];
    for (int i = 0; i < ledger.stockAccountsData.names.length; i++) {
      stockAccounts.add(
        Income(
          ledger.stockAccountsData.names[i],
          ledger.stockAccountsData.perDay[i],
          icon: ledger.stockAccountsData.icons[i],
          amount: ledger.stockAccountsData.amounts[i],
          interest: ledger.stockAccountsData.ratesOfReturn[i],
        ),
      );
    }
    return stockAccounts;
  }

  @override
  void initState() {
    super.initState();

    stockAccounts = getStockAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
