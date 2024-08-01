import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
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
  List<Income> properties = <Income>[];

  Widget getCardWidget(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardTitle: 'Real estate',
          itemName: 'property',
          cardType: CardType.realEstate,
          incomes: properties,
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
        return SmallCardContainer(
          cardTitle: 'Real estate',
          perDay: ledger.realEstateData.totalPerDay,
          investedAmount: ledger.realEstateData.totalInvested,
        );
    }
  }

  List<Income> getProperties() {
    List<Income> properties = <Income>[];
    for (int i = 0; i < ledger.realEstateData.locations.length; i++) {
      properties.add(
        Income(
          ledger.realEstateData.locations[i],
          ledger.realEstateData.perDay[i],
          icon: ledger.realEstateData.icons[i],
          description: ledger.realEstateData.descriptions[i],
          amount: ledger.realEstateData.capitals[i],
          payment: ledger.realEstateData.payments[i],
          interest: ledger.realEstateData.appreciations[i],
          revenue: ledger.realEstateData.revenues[i],
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
