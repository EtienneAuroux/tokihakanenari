import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'dart:developer' as developer;

class BigContent extends StatefulWidget {
  final CardType cardType;
  final List<Row> cardItems;
  final void Function() onUpdateItems;

  const BigContent({
    super.key,
    required this.cardType,
    required this.cardItems,
    required this.onUpdateItems,
  });

  @override
  State<BigContent> createState() => _BigContentState();
}

class _BigContentState extends State<BigContent> {
  Ledger ledger = Ledger();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
      child: Column(
        children: [
          const Text(
            'Saving accounts',
            style: TextStyles.cardTitle,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.cardItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: List.generate(
                    widget.cardItems.length,
                    (index) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Listener(
                        onPointerDown: (event) {
                          developer.log('down');
                        },
                        onPointerUp: (event) {
                          developer.log('up');
                        },
                      ),
                    ),
                  )[index],
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
                style: TextStyles.cardBody,
                textAlign: TextAlign.center,
              ),
            ),
            onDoubleTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewIncomeDialog(
                      cardType: widget.cardType,
                      onNewIncomeCallback: (List<dynamic> newSavingAccount) {
                        ledger.addCardData(widget.cardType, newSavingAccount);
                        widget.onUpdateItems();
                        ledger.addCarouselCard(widget.cardType);
                      },
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
