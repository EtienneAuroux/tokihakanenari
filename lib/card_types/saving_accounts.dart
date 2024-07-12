import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/add_new_dialog.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
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
  late List<Widget> savingAccounts;
  int numberOfSavingAccounts = 0;
  TextEditingController accountNameController = TextEditingController();

  List<Widget> initializeSavingAccounts() {
    return <Widget>[
      const Text(
        'Saving accounts',
        style: TextStyles.bigCardTitle,
      ),
      const Icon(Icons.new_label),
    ];
  }

  // void addSavingAccount() {
  //   savingAccounts.insert(
  //       savingAccounts.length - 1,
  //       const Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Icon(Icons.abc),
  //           Text(
  //             'amount',
  //             style: TextStyles.bigCardText,
  //           ),
  //           Text(
  //             'rate',
  //             style: TextStyles.bigCardText,
  //           ),
  //         ],
  //       ));
  //   setState(() {});
  // }

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    switch (cardStatus) {
      case CardSize.big:
        return ListView.builder(
          itemCount: savingAccounts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: TextButton(
                onPressed: () {
                  // savingAccountDialog(index, numberOfSavingAccounts);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddNewDialog(cardType: CardType.savingAccounts);
                      });
                },
                child: savingAccounts[index],
              ),
            );
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
        return const Center(
          child: Text(
            'Saving accounts',
            style: TextStyles.smallCardTitle,
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    savingAccounts = initializeSavingAccounts();
  }

  @override
  void dispose() {
    accountNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
