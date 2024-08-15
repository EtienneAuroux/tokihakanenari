import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        return Center(
          child: Text(
            AppLocalizations.of(context)!.indexFunds,
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return SmallCardContainer(
          cardTitle: AppLocalizations.of(context)!.indexFunds,
          perDay: ledger.indexFundsData.totalPerDay,
          investedAmount: ledger.indexFundsData.totalInvested,
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
          interest: ledger.indexFundsData.ratesOfReturn[i],
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
