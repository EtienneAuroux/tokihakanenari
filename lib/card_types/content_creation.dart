import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        return Center(
          child: Text(
            AppLocalizations.of(context)!.contentCreation,
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return SmallCardContainer(
          cardTitle: AppLocalizations.of(context)!.contentCreation,
          perDay: ledger.contentCreationData.totalPerDay,
        );
    }
  }

  List<Income> getContents() {
    List<Income> contents = <Income>[];
    for (int i = 0; i < ledger.contentCreationData.names.length; i++) {
      contents.add(
        Income(
          ledger.contentCreationData.names[i],
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
