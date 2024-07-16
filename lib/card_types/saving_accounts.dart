import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
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
  List<Widget> savingAccounts = <Widget>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(
            children: [
              const Text(
                'Saving accounts',
                style: TextStyles.bigCardTitle,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: savingAccounts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: savingAccounts[index],
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
                    'Double tap to add a new saving account.',
                    style: TextStyles.bigCardText,
                    textAlign: TextAlign.center,
                  ),
                ),
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewIncomeDialog(
                          cardType: CardType.savingAccounts,
                          onNewIncomeCallback: (List<dynamic> newSavingAccount) {
                            ledger.addCardData(CardType.savingAccounts, newSavingAccount);
                            savingAccounts = getSavingAccounts(CardSize.big);
                            setState(() {});
                            ledger.addCarouselCard(CardType.savingAccounts);
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
            'Saving accounts',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return const Center(
          child: Text(
            'Saving accounts',
            style: TextStyles.smallCardTitle,
          ),
        );
    }
  }

  List<Widget> getSavingAccounts(CardSize cardSize) {
    List<Widget> savingAccounts = <Widget>[];
    switch (cardSize) {
      case CardSize.big:
        for (int i = 0; i < ledger.savingAccountsData.names.length; i++) {
          savingAccounts.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(ledger.savingAccountsData.icons[i]),
              Flexible(
                child: Text(
                  ledger.savingAccountsData.names[i],
                  style: TextStyles.bigCardText,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                ),
              ),
              Text(
                '${ledger.savingAccountsData.amounts[i]}',
                style: TextStyles.bigCardText,
                textAlign: TextAlign.end,
              ),
              Text(
                '${ledger.savingAccountsData.interests[i].toStringAsFixed(2)} %',
                style: TextStyles.bigCardText,
                textAlign: TextAlign.end,
              ),
            ],
          ));
          savingAccounts.add(const SizedBox(
            height: 15,
          ));
        }
        break;
      case CardSize.mini:
        break;
      case CardSize.small:
        break;
    }
    return savingAccounts;
  }

  @override
  void initState() {
    super.initState();

    savingAccounts = getSavingAccounts(CardSize.big);
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
