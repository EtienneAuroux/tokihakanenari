import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/big_card_container.dart';
import 'package:tokihakanenari/customized_widgets/small_card_container.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
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
  List<Income> privateFunds = <Income>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigCardContainer(
          cardType: CardType.privateFunds,
          incomes: privateFunds,
          onUpdateItems: () {
            privateFunds = getPrivateFunds();
            if (mounted) {
              setState(() {});
            }
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
        return SmallCardContainer(
          cardTitle: 'Private funds',
          perDay: ledger.privateFundsData.totalPerDay,
          investedAmount: ledger.privateFundsData.totalInvested,
        );
    }
  }

  List<Income> getPrivateFunds() {
    List<Income> privateFunds = <Income>[];
    for (int i = 0; i < ledger.privateFundsData.names.length; i++) {
      privateFunds.add(
        Income(
          ledger.privateFundsData.names[i],
          ledger.privateFundsData.perDay[i],
          icon: ledger.privateFundsData.icons[i],
          amount: ledger.privateFundsData.amounts[i],
          interest: ledger.privateFundsData.ratesOfReturn[i],
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
