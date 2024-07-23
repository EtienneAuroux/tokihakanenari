import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class TotalIncome extends StatefulWidget {
  final CardSize cardSize;

  const TotalIncome({
    super.key,
    required this.cardSize,
  });

  @override
  State<TotalIncome> createState() => _TotalIncomeState();
}

class _TotalIncomeState extends State<TotalIncome> {
  Ledger ledger = Ledger();
  List<Widget> totalIncomes = <Widget>[];

  Widget getCardContent(CardSize cardStatus, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.fromLTRB(0, size.height / 20, 0, 0),
          child: Column(children: [
            const Text(
              'Total income',
              style: TextStyles.cardTitle,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: totalIncomes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: totalIncomes[index],
                  );
                },
              ),
            ),
          ]),
        );
      case CardSize.mini:
        throw ErrorDescription('TotalIncome should not be used as a mini card.');
      case CardSize.small:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Total income',
                style: TextStyles.cardTitle,
              ),
              Text(
                '${ledger.totalIncomeData.totalIncomePerDay.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              Text(
                '${ledger.totalIncomeData.totalInvested} invested',
                style: TextStyles.cardBody,
              ),
            ],
          ),
        );
    }
  }

  List<Widget> getTotalIncomesList() {
    List<Widget> totalIncomes = <Widget>[];
    if (ledger.carouselCards.contains(CardType.contentCreation)) {
      totalIncomes.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Content creation:',
                  style: TextStyles.cardBody,
                ),
                Text(
                  '${ledger.contentCreationData.totalPerDay.toStringAsFixed(2)} / day',
                  style: TextStyles.cardBody,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    if (ledger.carouselCards.contains(CardType.indexFunds)) {
      totalIncomes.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Index funds:',
              style: TextStyles.cardBody,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${ledger.indexFundsData.totalInvested}',
                  style: TextStyles.cardBody,
                ),
                Text(
                  '${ledger.indexFundsData.totalPerDay.toStringAsFixed(2)} / day',
                  style: TextStyles.cardBody,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    if (ledger.carouselCards.contains(CardType.privateFunds)) {
      totalIncomes.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Private funds:',
              style: TextStyles.cardBody,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${ledger.privateFundsData.totalInvested}',
                  style: TextStyles.cardBody,
                ),
                Text(
                  '${ledger.privateFundsData.totalPerDay.toStringAsFixed(2)} / day',
                  style: TextStyles.cardBody,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    if (ledger.carouselCards.contains(CardType.realEstate)) {
      totalIncomes.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real estate:',
              style: TextStyles.cardBody,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${ledger.realEstateData.totalInvested}',
                  style: TextStyles.cardBody,
                ),
                Text(
                  '${ledger.realEstateData.totalPerDay.toStringAsFixed(2)} / day',
                  style: TextStyles.cardBody,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    if (ledger.carouselCards.contains(CardType.salaries)) {
      totalIncomes.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Salaries:',
                  style: TextStyles.cardBody,
                ),
                Text(
                  '${ledger.salariesData.totalPerDay.toStringAsFixed(2)} / day',
                  style: TextStyles.cardBody,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    if (ledger.carouselCards.contains(CardType.savingAccounts)) {
      totalIncomes.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saving accounts:',
              style: TextStyles.cardBody,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${ledger.savingAccountsData.totalInvested}',
                  style: TextStyles.cardBody,
                ),
                Text(
                  '${ledger.savingAccountsData.totalPerDay.toStringAsFixed(2)} / day',
                  style: TextStyles.cardBody,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    if (ledger.carouselCards.contains(CardType.stockAccounts)) {
      totalIncomes.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stock accounts:',
              style: TextStyles.cardBody,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${ledger.stockAccountsData.totalInvested}',
                  style: TextStyles.cardBody,
                ),
                Text(
                  '${ledger.stockAccountsData.totalPerDay.toStringAsFixed(2)} / day',
                  style: TextStyles.cardBody,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    return totalIncomes;
  }

  @override
  void initState() {
    super.initState();

    totalIncomes = getTotalIncomesList();

    ledger.addListener(() {
      totalIncomes = getTotalIncomesList();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    ledger.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize, context);
  }
}
