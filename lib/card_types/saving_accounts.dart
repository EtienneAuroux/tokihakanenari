import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/big_content.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';
import 'dart:developer' as developer;

class SavingAccounts extends StatefulWidget {
  final CardSize cardSize;

  const SavingAccounts({
    super.key,
    required this.cardSize,
  });

  @override
  State<SavingAccounts> createState() => _SavingAccountsState();
}

class _SavingAccountsState extends State<SavingAccounts> {
  Ledger ledger = Ledger();
  List<Row> savingAccounts = <Row>[];

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return BigContent(
          cardTitle: 'Saving accounts',
          itemName: 'saving account',
          cardType: CardType.savingAccounts,
          cardItems: savingAccounts,
          onUpdateItems: () {
            savingAccounts = getSavingAccounts();
            if (mounted) {
              setState(() {});
            }
          },
          onDeleteItem: () {
            savingAccounts = getSavingAccounts();
            if (mounted) {
              setState(() {});
            }
          },
        );
      case CardSize.mini:
        return const Center(
          child: Text(
            'Saving accounts',
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
                'Saving accounts',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.savingAccountsData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.savingAccountsData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Row> getSavingAccounts() {
    List<Row> savingAccounts = <Row>[];
    for (int i = 0; i < ledger.savingAccountsData.names.length; i++) {
      savingAccounts.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(ledger.savingAccountsData.icons[i]),
            Flexible(
              child: Text(
                ledger.savingAccountsData.names[i],
                style: TextStyles.cardBody,
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            Text(
              '${ledger.savingAccountsData.amounts[i]}',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
            Text(
              '${ledger.savingAccountsData.interests[i].toStringAsFixed(2)} %',
              style: TextStyles.cardBody,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      );
    }
    return savingAccounts;
  }

  @override
  void initState() {
    super.initState();

    savingAccounts = getSavingAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
