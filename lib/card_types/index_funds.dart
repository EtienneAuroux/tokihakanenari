import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class IndexFunds extends StatefulWidget {
  final CardSize cardSize;

  const IndexFunds({
    super.key,
    required this.cardSize,
  });

  @override
  State<IndexFunds> createState() => _IndexFundsState();
}

class _IndexFundsState extends State<IndexFunds> {
  Ledger ledger = Ledger();
  List<Income> indexFunds = <Income>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardTitle: 'Index funds',
          itemName: 'index fund',
          cardType: CardType.indexFunds,
          incomes: indexFunds,
          onUpdateItems: () {
            indexFunds = getIndexFunds();
            if (mounted) {
              setState(() {});
            }
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Index funds',
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
                'Index funds',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.indexFundsData.totalPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.indexFundsData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Income> getIndexFunds() {
    List<Income> indexFunds2 = <Income>[];
    for (int i = 0; i < ledger.indexFundsData.names.length; i++) {
      indexFunds2.add(
        Income(
          ledger.indexFundsData.names[i],
          ledger.indexFundsData.perDay[i],
          icon: ledger.indexFundsData.icons[i],
          amount: ledger.indexFundsData.amounts[i],
          interest: ledger.indexFundsData.interests[i],
        ),
      );
    }
    return indexFunds2;
  }

  @override
  void initState() {
    super.initState();

    indexFunds = getIndexFunds();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
