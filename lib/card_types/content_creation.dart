import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
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
  List<Income> contents = <Income>[];

  Widget getCardWidget(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardTitle: 'Content creation',
          itemName: 'content creation platform',
          cardType: CardType.contentCreation,
          incomes: contents,
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
                '${ledger.contentCreationData.totalPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Income> getContents() {
    List<Income> contents = <Income>[];
    for (int i = 0; i < ledger.contentCreationData.platforms.length; i++) {
      contents.add(
        Income(
          ledger.contentCreationData.platforms[i],
          ledger.contentCreationData.perDay[i],
          icon: ledger.contentCreationData.icons[i],
          revenue: ledger.contentCreationData.revenues[i],
          timePeriod: ledger.contentCreationData.timePeriods[i],
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
