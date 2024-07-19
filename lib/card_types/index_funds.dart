import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_content.dart';
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
  List<Row> indexFunds = <Row>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigContent(
          cardTitle: 'Index funds',
          itemName: 'index fund',
          cardType: CardType.indexFunds,
          cardItems: indexFunds,
          onUpdateItems: () {
            indexFunds = getIndexFunds();
            setState(() {});
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
                '${ledger.indexFundsData.earnedPerDay.toStringAsFixed(2)} / day',
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

  List<Row> getIndexFunds() {
    List<Row> indexFunds = <Row>[];
    for (int i = 0; i < ledger.indexFundsData.names.length; i++) {
      indexFunds.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(ledger.indexFundsData.icons[i]),
            Flexible(
              child: Text(
                ledger.indexFundsData.names[i],
                style: TextStyles.cardBody,
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            Text(
              '${ledger.indexFundsData.amounts[i]}',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
            Text(
              '${ledger.indexFundsData.interests[i].toStringAsFixed(2)} %',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      );
    }
    return indexFunds;
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
