import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_content.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class RealEstate extends StatefulWidget {
  final CardSize cardSize;

  const RealEstate({
    super.key,
    required this.cardSize,
  });

  @override
  State<RealEstate> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstate> {
  Ledger ledger = Ledger();
  List<Row> properties = <Row>[];

  Widget getCardWidget(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigContent(
          cardTitle: 'Real estate',
          itemName: 'property',
          cardType: CardType.realEstate,
          cardItems: properties,
          onUpdateItems: () {
            properties = getProperties();
            if (mounted) {
              setState(() {});
            }
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Real estate',
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
                'Real estate',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.realEstateData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.realEstateData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Row> getProperties() {
    List<Row> properties = <Row>[];
    for (int i = 0; i < ledger.realEstateData.locations.length; i++) {
      properties.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tooltip(
              message: ledger.realEstateData.descriptions[i],
              showDuration: const Duration(seconds: 2),
              child: Text(
                ledger.realEstateData.locations[i],
                textAlign: TextAlign.start,
                style: TextStyles.cardBody,
              ),
            ),
            Text(
              '${ledger.realEstateData.capitals[i].round()}',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
            Text(
              '${ledger.realEstateData.fullReturns[i].toStringAsFixed(2)} %',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      );
    }
    return properties;
  }

  @override
  void initState() {
    super.initState();

    properties = getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return getCardWidget(widget.cardSize);
  }
}
