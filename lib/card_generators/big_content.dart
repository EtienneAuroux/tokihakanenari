import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'dart:developer' as developer;

class BigContent extends StatefulWidget {
  final String cardTitle;
  final String itemName;
  final CardType cardType;
  final List<Row> cardItems;
  final void Function() onUpdateItems;

  const BigContent({
    super.key,
    required this.cardTitle,
    required this.itemName,
    required this.cardType,
    required this.cardItems,
    required this.onUpdateItems,
  });

  @override
  State<BigContent> createState() => _BigContentState();
}

class _BigContentState extends State<BigContent> {
  Ledger ledger = Ledger();
  List<bool> pressingItem = List.filled(100000, false);
  List<double> gradientEnd = List.filled(100000, -1);

  Future<void> updateGradientEnd(int itemIndex) async {
    int counter = 0;
    while (pressingItem[itemIndex]) {
      setState(() {
        gradientEnd[itemIndex] += 0.01;
      });
      await Future.delayed(const Duration(milliseconds: 1));
      counter += 1;
      if (counter == 300) {
        pressingItem[itemIndex] = false;
        ledger.deleteCardData(widget.cardType, itemIndex);
        if (widget.cardItems.length == 1) {
          ledger.deleteCarouselCard(widget.cardType);
        }
      }
    }
    if (!pressingItem[itemIndex]) {
      setState(() {
        gradientEnd[itemIndex] = -1;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    ledger.addListener(() {
      widget.onUpdateItems();
    });
  }

  @override
  void dispose() {
    ledger.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
      child: Column(
        children: [
          Text(
            widget.cardTitle,
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
                  child: GestureDetector(
                    onTapDown: (details) {
                      pressingItem[index] = true;
                      updateGradientEnd(index);
                    },
                    onTapUp: (details) {
                      pressingItem[index] = false;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.red.withAlpha(0)],
                          begin: Alignment.centerLeft,
                          end: Alignment(gradientEnd[index], 0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: widget.cardItems[index],
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.topCenter,
              height: size.height / 4,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Double tap to add a new ${widget.itemName}.',
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
                      onNewIncomeCallback: (List<dynamic> newIncome) {
                        ledger.addCardData(widget.cardType, newIncome);
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
