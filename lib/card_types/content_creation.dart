import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ContentCreation extends StatefulWidget {
  final CardSize cardSize;

  const ContentCreation({
    super.key,
    required this.cardSize,
  });

  @override
  State<ContentCreation> createState() => _ContentCreationState();
}

class _ContentCreationState extends State<ContentCreation> {
  Ledger ledger = Ledger();
  List<Row> contents = <Row>[];

  Widget getCardWidget(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardTitle: 'Content creation',
          itemName: 'content creation platform',
          cardType: CardType.contentCreation,
          cardItems: contents,
          onUpdateItems: () {
            contents = getContents();
            if (mounted) {
              setState(() {});
            }
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Content creation',
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
                'Content creation',
                style: TextStyles.cardTitle,
                textAlign: TextAlign.center,
              ),
              Text(
                '${ledger.contentCreationData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Row> getContents() {
    List<Row> contents = <Row>[];
    for (int i = 0; i < ledger.contentCreationData.platforms.length; i++) {
      contents.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ledger.contentCreationData.platforms[i],
              style: TextStyles.cardBody,
              textAlign: TextAlign.start,
            ),
            Text(
              '${ledger.contentCreationData.revenues[i]} / ${ledger.contentCreationData.timePeriods[i].name}',
              style: TextStyles.cardBody,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
    }
    return contents;
  }

  @override
  void initState() {
    super.initState();

    contents = getContents();
  }

  @override
  Widget build(BuildContext context) {
    return getCardWidget(widget.cardSize);
  }
}
