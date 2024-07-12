import 'package:flutter/material.dart';
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

  // Future<void> alertPopup(String notification, {bool forceConnection = false}) async {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Connection issue:'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(notification),
  //             ],
  //           ),
  //         ),
  //         actions: forceConnection
  //             ? <Widget>[
  //                 TextButton(
  //                   child: const Text('Yes'),
  //                   onPressed: () {
  //                     // connect(forceConnection: true);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //                 TextButton(
  //                   child: const Text('No'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ]
  //             : <Widget>[
  //                 TextButton(
  //                   child: const Text('Ok'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //       );
  //     },
  //   );
  // }

  Future<void> savingAccountDialog(int index, int numberOfSavingAccounts) {
    Widget content;
    if (index == 0) {
      content = const Text('Display total');
    } else if (index == numberOfSavingAccounts + 1) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'New account:',
            style: TextStyles.bigCardTitle,
          ),
          const Row(
            children: [
              Icon(Icons.ac_unit_outlined),
              Icon(Icons.access_alarms),
            ],
          ),
          const Text('amount'),
          const Text('rate'),
          TextButton(onPressed: () {}, child: const Icon(Icons.send)),
        ],
      );
    } else {
      content = const Text('Modify account');
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: DecoratedBox(
              decoration: CardDecoration.getMiniDecoration(CardType.savingAccounts),
              child: content,
            ),
            contentPadding: const EdgeInsets.all(0),
          );
        });
  }

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
                  savingAccountDialog(index, numberOfSavingAccounts);
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
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
