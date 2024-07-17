import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
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
  List<Widget> stockAccounts = <Widget>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(
            children: [
              const Text(
                'Stock accounts',
                style: TextStyles.cardTitle,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: stockAccounts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: stockAccounts[index],
                    );
                  },
                ),
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.topCenter,
                  height: size.height / 4,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: const Text(
                    'Double tap to add a new stock account.',
                    style: TextStyles.cardBody,
                    textAlign: TextAlign.center,
                  ),
                ),
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewIncomeDialog(
                          cardType: CardType.stockAccounts,
                          onNewIncomeCallback: (List<dynamic> newStockAccount) {
                            ledger.addCardData(CardType.stockAccounts, newStockAccount);
                            stockAccounts = getStockAccountsList();
                            setState(() {});
                            ledger.addCarouselCard(CardType.stockAccounts);
                          },
                        );
                      });
                },
              ),
            ],
          ),
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

  List<Widget> getStockAccountsList() {
    List<Widget> stockAccounts = <Widget>[];
    for (int i = 0; i < ledger.stockAccountsData.names.length; i++) {
      stockAccounts.add(Row(
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
      ));
      stockAccounts.add(const SizedBox(
        height: 15,
      ));
    }
    return stockAccounts;
  }

  @override
  void initState() {
    super.initState();

    stockAccounts = getStockAccountsList();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
