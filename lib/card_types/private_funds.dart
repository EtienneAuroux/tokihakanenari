import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_content.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class PrivateFunds extends StatefulWidget {
  final CardSize cardSize;

  const PrivateFunds({
    super.key,
    required this.cardSize,
  });

  @override
  State<PrivateFunds> createState() => _PrivateFundsState();
}

class _PrivateFundsState extends State<PrivateFunds> {
  Ledger ledger = Ledger();
  List<Row> privateFunds = <Row>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigContent(
          cardTitle: 'Private funds',
          itemName: 'private fund',
          cardType: CardType.privateFunds,
          cardItems: privateFunds,
          onUpdateItems: () {
            privateFunds = getPrivateFunds();
            setState(() {});
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Private funds',
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
                'Private funds',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.privateFundsData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.privateFundsData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Row> getPrivateFunds() {
    List<Row> privateFunds = <Row>[];
    for (int i = 0; i < ledger.privateFundsData.names.length; i++) {
      privateFunds.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(ledger.privateFundsData.icons[i]),
            Flexible(
              child: Text(
                ledger.privateFundsData.names[i],
                style: TextStyles.cardBody,
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            Text(
              '${ledger.privateFundsData.amounts[i]}',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
            Text(
              '${ledger.privateFundsData.interests[i].toStringAsFixed(2)} %',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      );
    }
    return privateFunds;
  }

  @override
  void initState() {
    super.initState();

    privateFunds = getPrivateFunds();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
