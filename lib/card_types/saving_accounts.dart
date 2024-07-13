import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
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
  List<Widget> savingAccounts = <Widget>[
    const SizedBox(
      height: 10,
    )
  ];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
              Container(
                alignment: Alignment.topCenter,
                height: size.height / 4,
                child: GestureDetector(
                  child: const Text(
                    'Double tap to add a new saving account.',
                    style: TextStyles.bigCardText,
                    textAlign: TextAlign.center,
                  ),
                  onDoubleTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NewIncomeDialog(
                            cardType: CardType.savingAccounts,
                            onNewIncomeCallback: (List<dynamic> newSavingAccount) {
                              developer.log('received: $newSavingAccount');
                              Row savingAccount = Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(newSavingAccount[0]),
                                  Text(
                                    newSavingAccount[1],
                                    style: TextStyles.bigCardText,
                                  ),
                                  Text(
                                    newSavingAccount[2],
                                    style: TextStyles.bigCardText,
                                  ),
                                  Text(
                                    newSavingAccount[3],
                                    style: TextStyles.bigCardText,
                                  ),
                                ],
                              );
                              setState(() {
                                savingAccounts.add(const SizedBox(
                                  height: 15,
                                ));
                                savingAccounts.add(savingAccount);
                              });
                            },
                          );
                        });
                  },
                ),
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

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
