import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class Salaries extends StatefulWidget {
  final CardSize cardSize;

  const Salaries({
    super.key,
    required this.cardSize,
  });

  @override
  State<Salaries> createState() => _SalariesState();
}

class _SalariesState extends State<Salaries> {
  Ledger ledger = Ledger();
  List<Widget> salaries = <Widget>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(
            children: [
              const Text(
                'Salaries',
                style: TextStyles.cardTitle,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: salaries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: salaries[index],
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
                    'Double tap to add a new salary.',
                    style: TextStyles.cardBody,
                    textAlign: TextAlign.center,
                  ),
                ),
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewIncomeDialog(
                          cardType: CardType.salaries,
                          onNewIncomeCallback: (List<dynamic> newSalary) {
                            ledger.addCardData(CardType.salaries, newSalary);
                            salaries = getSalariesList();
                            setState(() {});
                            ledger.addCarouselCard(CardType.salaries);
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
            'Salaries',
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
                'Salaries',
                style: TextStyles.cardTitle,
              ),
              SizedBox(
                height: size.height / 10,
              ),
              Text(
                '${ledger.salariesData.earnedPerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              )
            ],
          ),
        );
    }
  }

  List<Widget> getSalariesList() {
    List<Widget> salaries = <Widget>[];
    for (int i = 0; i < ledger.salariesData.names.length; i++) {
      salaries.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(ledger.salariesData.icons[i]),
          Flexible(
            child: Text(
              ledger.salariesData.names[i],
              style: TextStyles.cardBody,
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
              softWrap: false,
              maxLines: 1,
            ),
          ),
          Text(
            '${ledger.salariesData.salaries[i]} / ${ledger.salariesData.timePeriods[i].name}',
            style: TextStyles.cardBody,
            textAlign: TextAlign.end,
          ),
        ],
      ));
      salaries.add(const SizedBox(
        height: 15,
      ));
    }
    return salaries;
  }

  @override
  void initState() {
    super.initState();

    salaries = getSalariesList();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
