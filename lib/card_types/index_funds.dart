import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class IndexFunds extends StatefulWidget {
  final CardSize cardSize;

  const IndexFunds({
    super.key,
    required this.cardSize,
  });

  @override
  State<IndexFunds> createState() => _IndexFundsState();
}

class _IndexFundsState extends State<IndexFunds> {
  Ledger ledger = Ledger();
  List<Widget> indexFunds = <Widget>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(
            children: [
              const Text(
                'Index funds',
                style: TextStyles.bigCardTitle,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: indexFunds.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: indexFunds[index],
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
                    'Double tap to add a new index fund.',
                    style: TextStyles.bigCardText,
                    textAlign: TextAlign.center,
                  ),
                ),
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewIncomeDialog(
                          cardType: CardType.indexFunds,
                          onNewIncomeCallback: (List<dynamic> newIndexFund) {
                            ledger.addCardData(CardType.indexFunds, newIndexFund);
                            indexFunds = getIndexFunds(CardSize.big);
                            setState(() {});
                            ledger.addCarouselCard(CardType.indexFunds);
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
            'Index funds',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return const Center(
          child: Text(
            'Index funds',
            style: TextStyles.smallCardTitle,
          ),
        );
    }
  }

  List<Widget> getIndexFunds(CardSize cardSize) {
    List<Widget> indexFunds = <Widget>[];
    switch (cardSize) {
      case CardSize.big:
        for (int i = 0; i < ledger.indexFundsData.names.length; i++) {
          indexFunds.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(ledger.indexFundsData.icons[i]),
              Flexible(
                child: Text(
                  ledger.indexFundsData.names[i],
                  style: TextStyles.bigCardText,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                ),
              ),
              Text(
                '${ledger.indexFundsData.amounts[i]}',
                style: TextStyles.bigCardText,
                textAlign: TextAlign.end,
              ),
              Text(
                '${ledger.indexFundsData.interests[i].toStringAsFixed(2)} %',
                style: TextStyles.bigCardText,
                textAlign: TextAlign.end,
              ),
            ],
          ));
          indexFunds.add(const SizedBox(
            height: 15,
          ));
        }
        break;
      case CardSize.mini:
        break;
      case CardSize.small:
        break;
    }
    return indexFunds;
  }

  @override
  void initState() {
    super.initState();

    indexFunds = getIndexFunds(CardSize.big);
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
