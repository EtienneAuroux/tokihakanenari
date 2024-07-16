import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/new_income_dialog.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ContentCreation extends StatefulWidget {
  final CardSize cardSize;

  const ContentCreation({
    super.key,
    required this.cardSize,
  });

  @override
  State<ContentCreation> createState() => _ContentCreationState();
}

class _ContentCreationState extends State<ContentCreation> {
  Ledger ledger = Ledger();
  List<Widget> contents = <Widget>[];

  Widget getCardWidget(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(
            children: [
              const Text(
                'Content creation',
                style: TextStyles.bigCardTitle,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: contents[index],
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
                    'Double tap to add a content platform.',
                    style: TextStyles.bigCardText,
                    textAlign: TextAlign.center,
                  ),
                ),
                onDoubleTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewIncomeDialog(
                          cardType: CardType.contentCreation,
                          onNewIncomeCallback: (List<dynamic> newContent) {
                            ledger.addCardData(CardType.contentCreation, newContent);
                            contents = getContents(CardSize.big);
                            setState(() {});
                            ledger.addCarouselCard(CardType.contentCreation);
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
            'Content creation',
            style: TextStyles.miniCardTitle,
            textAlign: TextAlign.center,
          ),
        );
      case CardSize.small:
        return Column(
          children: [
            const Text(
              'Content creation',
              style: TextStyles.smallCardTitle,
              textAlign: TextAlign.center,
            ),
            Text(
              '${ledger.contentCreationData.earnedPerDay} / day',
              style: TextStyles.smallCardText,
            ),
          ],
        );
    }
  }

  List<Widget> getContents(CardSize cardSize) {
    List<Widget> contents = <Widget>[];
    switch (cardSize) {
      case CardSize.big:
        for (int i = 0; i < ledger.contentCreationData.platforms.length; i++) {
          contents.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ledger.contentCreationData.platforms[i],
                style: TextStyles.bigCardText,
                textAlign: TextAlign.start,
              ),
              Text(
                '${ledger.contentCreationData.revenues[i]} / ${ledger.contentCreationData.timePeriods[i].name}',
                style: TextStyles.bigCardText,
                textAlign: TextAlign.start,
              ),
            ],
          ));
          contents.add(const SizedBox(
            height: 15,
          ));
        }
        break;
      case CardSize.mini:
        break;
      case CardSize.small:
        break;
    }
    return contents;
  }

  @override
  void initState() {
    super.initState();

    contents = getContents(CardSize.big);
  }

  @override
  Widget build(BuildContext context) {
    return getCardWidget(widget.cardSize, context);
  }
}
