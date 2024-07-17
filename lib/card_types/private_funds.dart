import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
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
  List<Widget> privateFunds = <Widget>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(
            children: [
              const Text(
                'Private funds',
                style: TextStyles.cardTitle,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: privateFunds.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: privateFunds[index],
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
                    'Double tap to add a new private fund.',
                    style: TextStyles.cardBody,
                    textAlign: TextAlign.center,
                  ),
                ),
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewIncomeDialog(
                          cardType: CardType.privateFunds,
                          onNewIncomeCallback: (List<dynamic> newPrivateFund) {
                            ledger.addCardData(CardType.privateFunds, newPrivateFund);
                            privateFunds = getPrivateFundsList();
                            setState(() {});
                            ledger.addCarouselCard(CardType.privateFunds);
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
            'Private funds',
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
                'Private funds',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.privateFundsData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.privateFundsData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Widget> getPrivateFundsList() {
    List<Widget> privateFunds = <Widget>[];
    for (int i = 0; i < ledger.privateFundsData.names.length; i++) {
      privateFunds.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(ledger.privateFundsData.icons[i]),
          Flexible(
            child: Text(
              ledger.privateFundsData.names[i],
              style: TextStyles.cardBody,
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
              softWrap: false,
              maxLines: 1,
            ),
          ),
          Text(
            '${ledger.privateFundsData.amounts[i]}',
            style: TextStyles.cardBody,
            textAlign: TextAlign.end,
          ),
          Text(
            '${ledger.privateFundsData.interests[i].toStringAsFixed(2)} %',
            style: TextStyles.cardBody,
            textAlign: TextAlign.end,
          ),
        ],
      ));
      privateFunds.add(const SizedBox(
        height: 15,
      ));
    }
    return privateFunds;
  }

  @override
  void initState() {
    super.initState();

    privateFunds = getPrivateFundsList();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
