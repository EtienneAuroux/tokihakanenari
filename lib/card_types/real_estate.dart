import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
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
  List<Widget> properties = <Widget>[];

  Widget getCardWidget(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(
            children: [
              const Text(
                'Real estate',
                style: TextStyles.bigCardTitle,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: properties.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: properties[index],
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
                    'Double tap to add a new property.',
                    style: TextStyles.bigCardText,
                    textAlign: TextAlign.center,
                  ),
                ),
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewIncomeDialog(
                          cardType: CardType.realEstate,
                          onNewIncomeCallback: (List<dynamic> newProperty) {
                            ledger.addCardData(CardType.realEstate, newProperty);
                            properties = getProperties(CardSize.big);
                            setState(() {});
                            ledger.addCarouselCard(CardType.realEstate);
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
            'Real estate',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return Column(children: [
          const Text(
            'Real estate',
            style: TextStyles.smallCardTitle,
          ),
          Text(
            '${ledger.realEstateData.earnedPerDay} / day',
            style: TextStyles.smallCardText,
          ),
          Text(
            '${ledger.realEstateData.totalInvested} invested',
            style: TextStyles.smallCardText,
          ),
        ]);
    }
  }

  List<Widget> getProperties(CardSize cardSize) {
    List<Widget> properties = <Widget>[];
    switch (cardSize) {
      case CardSize.big:
        for (int i = 0; i < ledger.realEstateData.locations.length; i++) {
          properties.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: ledger.realEstateData.descriptions[i],
                showDuration: const Duration(seconds: 4),
                child: Text(
                  ledger.realEstateData.locations[i],
                  textAlign: TextAlign.start,
                  style: TextStyles.bigCardText,
                ),
              ),
              Text(
                '${ledger.realEstateData.capitals[i].round()}',
                style: TextStyles.bigCardText,
                textAlign: TextAlign.end,
              ),
              Text(
                '${ledger.realEstateData.fullReturns[i].toStringAsFixed(2)} %',
                style: TextStyles.bigCardText,
                textAlign: TextAlign.end,
              ),
            ],
          ));
          properties.add(const SizedBox(
            height: 15,
          ));
        }
        break;
      case CardSize.mini:
        break;
      case CardSize.small:
        break;
    }
    return properties;
  }

  @override
  void initState() {
    super.initState();

    properties = getProperties(CardSize.big);
  }

  @override
  Widget build(BuildContext context) {
    return getCardWidget(widget.cardSize, context);
  }
}
