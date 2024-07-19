import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_content.dart';
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
  List<Row> stockAccounts = <Row>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigContent(
          cardTitle: 'Stock accounts',
          itemName: 'stock account',
          cardType: CardType.stockAccounts,
          cardItems: stockAccounts,
          onUpdateItems: () {
            stockAccounts = getStockAccounts();
            setState(() {});
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
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Stock accounts',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.stockAccountsData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.stockAccountsData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Row> getStockAccounts() {
    List<Row> stockAccounts = <Row>[];
    for (int i = 0; i < ledger.stockAccountsData.names.length; i++) {
      stockAccounts.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(ledger.stockAccountsData.icons[i]),
            Flexible(
              child: Text(
                ledger.stockAccountsData.names[i],
                style: TextStyles.cardBody,
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            Text(
              '${ledger.stockAccountsData.amounts[i]}',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
            Text(
              '${ledger.stockAccountsData.interests[i]} %',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
          ],
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
