import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
import 'package:tokihakanenari/customized_widgets/income_container.dart';
import 'package:tokihakanenari/customized_widgets/tap_indicator.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

// import 'dart:developer' as developer;

class BigCardContainer extends StatefulWidget {
  final String cardTitle;
  final String itemName;
  final CardType cardType;
  final List<Income> incomes;
  final void Function() onUpdateItems;
  final void Function()? onRequestSettings;

  const BigCardContainer({
    super.key,
    required this.cardTitle,
    required this.itemName,
    required this.cardType,
    required this.incomes,
    required this.onUpdateItems,
    this.onRequestSettings,
  });

  @override
  State<BigCardContainer> createState() => _BigCardContainerState();
}

class _BigCardContainerState extends State<BigCardContainer> {
  Ledger ledger = Ledger();
  List<bool> pressingItem = List.filled(100000, false);
  List<double> gradientEnd = List.filled(100000, -1);

  Future<void> updateGradientEnd(int itemIndex) async {
    int counter = 0;
    while (pressingItem[itemIndex]) {
      if (counter > 20) {
        setState(() {
          gradientEnd[itemIndex] += 0.01;
        });
      }
      await Future.delayed(const Duration(milliseconds: 1));
      counter += 1;
      if (counter == 320) {
        pressingItem[itemIndex] = false;
        if (widget.cardType != CardType.totalIncome) {
          ledger.deleteCardData(widget.cardType, itemIndex);
          if (widget.incomes.length == 1) {
            ledger.deleteCarouselCard(widget.cardType);
          }
        } else {
          ledger.deleteCarouselCard(widget.incomes[itemIndex].subIncomeCardType!);
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

    return SafeArea(
      child: Column(
        children: [
          Text(
            widget.cardTitle,
            style: TextStyles.cardTitle,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            constraints: BoxConstraints(maxHeight: size.height * 0.75),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              shrinkWrap: true,
              itemCount: widget.incomes.length,
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
                    onTapCancel: () {
                      pressingItem[index] = false;
                    },
                    onDoubleTap: () {
                      pressingItem[index] = false;
                      if (widget.cardType != CardType.totalIncome) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return NewIncomeDialog(
                                cardType: widget.cardType,
                                onNewIncomeCallback: (List<dynamic> updatedIncome) {
                                  ledger.updateCardData(widget.cardType, index, updatedIncome);
                                  widget.onUpdateItems();
                                },
                                modify: index,
                              );
                            });
                      }
                    },
                    child: IncomeContainer(
                      cardType: widget.cardType,
                      income: widget.incomes[index],
                      gradientEnd: gradientEnd[index],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: widget.cardType != CardType.totalIncome
                ? GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: widget.incomes.isEmpty
                          ? TapIndicator(
                              size: size,
                            )
                          : null,
                    ),
                    onDoubleTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NewIncomeDialog(
                              cardType: widget.cardType,
                              onNewIncomeCallback: (List<dynamic> newIncome) {
                                ledger.addCarouselCard(widget.cardType);
                                ledger.addCardData(widget.cardType, newIncome);
                                widget.onUpdateItems();
                              },
                            );
                          });
                    },
                  )
                : Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(
                        FontAwesome5.tools_1,
                        color: Colors.black,
                        size: 40,
                      ),
                      padding: const EdgeInsets.all(15),
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        widget.onRequestSettings?.call();
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
