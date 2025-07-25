import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/rotating_button.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'dart:developer' as developer;

class IncomeContainer extends StatefulWidget {
  final CardType cardType;
  final Income income;
  final double gradientEnd;

  const IncomeContainer({
    super.key,
    required this.cardType,
    required this.income,
    required this.gradientEnd,
  });

  @override
  State<IncomeContainer> createState() => _IncomeContainerState();
}

class _IncomeContainerState extends State<IncomeContainer> {
  Ledger ledger = Ledger();
  bool expanded = false;
  final BorderSide borderSide = BorderSide(
    color: Colors.black.withAlpha(50),
    width: 4 * Dimensions.widthUnit,
  );

  List<Widget> getHeader(CardType cardType) {
    if (widget.cardType == CardType.totalIncome) {
      return [
        Text(
          widget.income.id,
          style: TextStyles.cardBody,
        ),
      ];
    } else {
      return [
        Icon(
          widget.income.icon,
          size: Dimensions.iconSize,
        ),
        SizedBox(
          width: 20 * Dimensions.widthUnit,
        ),
        Text(
          widget.income.id,
          style: TextStyles.cardBody,
        ),
      ];
    }
  }

  List<Widget> getExtraInformation(CardType cardType) {
    if (cardType == CardType.contentCreation || cardType == CardType.salaries) {
      return [
        Text(
          '${AppLocalizations.of(context)!.revenue}: ${ledger.formatMonetaryAmounts(widget.income.revenue!, false, context)} / ${widget.income.timePeriod!.name}',
          style: TextStyles.incomeExtraInformation,
        ),
      ];
    } else if (cardType == CardType.customIncome) {
      return [
        Text(
          '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(widget.income.amount!, false, context)}',
          style: TextStyles.incomeExtraInformation,
        ),
        SizedBox(
          height: 5 * Dimensions.heightUnit,
        ),
        Text(
          '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(widget.income.interest!, true, context)}',
          style: TextStyles.incomeExtraInformation,
        ),
        SizedBox(
          height: 5 * Dimensions.heightUnit,
        ),
        Text(
          '${AppLocalizations.of(context)!.generatedRevenue}: ${ledger.formatMonetaryAmounts(widget.income.revenue!, false, context)} / ${AppLocalizations.of(context)!.year}',
          style: TextStyles.incomeExtraInformation,
        )
      ];
    } else if (cardType == CardType.realEstate) {
      return [
        Text(
          '${AppLocalizations.of(context)!.description}: ${widget.income.description}',
          style: TextStyles.incomeExtraInformation,
        ),
        SizedBox(
          height: 5 * Dimensions.heightUnit,
        ),
        Text(
          '${AppLocalizations.of(context)!.capital}: ${ledger.formatMonetaryAmounts(widget.income.amount!, false, context)}',
          style: TextStyles.incomeExtraInformation,
        ),
        SizedBox(
          height: 5 * Dimensions.heightUnit,
        ),
        Text(
          '${AppLocalizations.of(context)!.appreciation}: ${ledger.formatMonetaryAmounts(widget.income.interest!, true, context)}',
          style: TextStyles.incomeExtraInformation,
        ),
        SizedBox(
          height: 5 * Dimensions.heightUnit,
        ),
        Text(
          '${AppLocalizations.of(context)!.monthlyPayment}: ${ledger.formatMonetaryAmounts(widget.income.payment!, false, context)}',
          style: TextStyles.incomeExtraInformation,
        ),
        SizedBox(
          height: 5 * Dimensions.heightUnit,
        ),
        Text(
          '${AppLocalizations.of(context)!.generatedRevenue}: ${ledger.formatMonetaryAmounts(widget.income.revenue!, false, context)} / ${AppLocalizations.of(context)!.year}',
          style: TextStyles.incomeExtraInformation,
        )
      ];
    } else if (cardType == CardType.totalIncome) {
      switch (widget.income.subIncomeCardType) {
        case null:
          throw ErrorDescription('For Cardtype.totalIncome, income.subIncomeCardType should not be null.');
        case CardType.addCard:
          throw ErrorDescription('It should not be possible to have income.subIncomeCardType = addCard');
        case CardType.contentCreation:
          return [
            Text(
              '${AppLocalizations.of(context)!.revenue}: ${ledger.formatMonetaryAmounts(ledger.contentCreationData.totalIncome, false, context)} / ${AppLocalizations.of(context)!.year}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.customIncome:
          return [
            Text(
              '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(ledger.customIncomeData.totalInvested, false, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
            SizedBox(
              height: 5 * Dimensions.heightUnit,
            ),
            Text(
              '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(ledger.customIncomeData.totalRateOfReturn, true, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.indexFunds:
          return [
            Text(
              '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(ledger.indexFundsData.totalInvested, false, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
            SizedBox(
              height: 5 * Dimensions.heightUnit,
            ),
            Text(
              '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(ledger.indexFundsData.totalRateOfReturn, true, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.privateFunds:
          return [
            Text(
              '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(ledger.privateFundsData.totalInvested, false, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
            SizedBox(
              height: 5 * Dimensions.heightUnit,
            ),
            Text(
              '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(ledger.privateFundsData.totalRateOfReturn, true, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.realEstate:
          return [
            Text(
              '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(ledger.realEstateData.totalInvested, false, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
            SizedBox(
              height: 5 * Dimensions.heightUnit,
            ),
            Text(
              '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(ledger.realEstateData.totalRateOfReturn, true, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.salaries:
          return [
            Text(
              '${AppLocalizations.of(context)!.revenue}: ${ledger.formatMonetaryAmounts(ledger.salariesData.totalIncome, false, context)} / ${AppLocalizations.of(context)!.year}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.savingAccounts:
          return [
            Text(
              '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(ledger.savingAccountsData.totalInvested, false, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
            SizedBox(
              height: 5 * Dimensions.heightUnit,
            ),
            Text(
              '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(ledger.savingAccountsData.totalRateOfReturn, true, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.stockAccounts:
          return [
            Text(
              '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(ledger.stockAccountsData.totalInvested, false, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
            SizedBox(
              height: 5 * Dimensions.heightUnit,
            ),
            Text(
              '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(ledger.stockAccountsData.totalRateOfReturn, true, context)}',
              style: TextStyles.incomeExtraInformation,
            ),
          ];
        case CardType.totalIncome:
          throw ErrorDescription('It should not be possible to have income.subIncomeCardType = totalIncome');
        case CardType.settings:
          throw ErrorDescription('It should not be possible to have income.subIncomeCardType = settings');
      }
    } else {
      return [
        Text(
          '${AppLocalizations.of(context)!.investment}: ${ledger.formatMonetaryAmounts(widget.income.amount!, false, context)}',
          style: TextStyles.incomeExtraInformation,
        ),
        SizedBox(
          height: 5 * Dimensions.heightUnit,
        ),
        Text(
          '${AppLocalizations.of(context)!.averageReturn}: ${ledger.formatMonetaryAmounts(widget.income.interest!, true, context)}',
          style: TextStyles.incomeExtraInformation,
        ),
      ];
    }
  }

  double getExpandedHeight(CardType cardType) {
    if (cardType == CardType.contentCreation || cardType == CardType.salaries) {
      return 30 * Dimensions.heightUnit;
    } else if (cardType == CardType.customIncome) {
      return 90 * Dimensions.heightUnit;
    } else if (cardType == CardType.realEstate) {
      return 140 * Dimensions.heightUnit;
    } else if (cardType == CardType.totalIncome) {
      if (widget.income.subIncomeCardType == CardType.contentCreation || widget.income.subIncomeCardType == CardType.salaries) {
        return 30 * Dimensions.heightUnit;
      } else {
        return 60 * Dimensions.heightUnit;
      }
    } else {
      return 60 * Dimensions.heightUnit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: widget.cardType != CardType.totalIncome
              ? null
              : CardDecoration.getBigDecoration(
                  widget.income.subIncomeCardType!,
                  totalIncome: true,
                ),
          foregroundDecoration: BoxDecoration(
            border: Border(
              bottom: borderSide,
              right: borderSide,
            ),
            borderRadius: BorderRadius.circular(10 * Dimensions.heightUnit),
            gradient: LinearGradient(
              colors: [Colors.red, Colors.red.withAlpha(0)],
              begin: Alignment.centerLeft,
              end: Alignment(widget.gradientEnd, 0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15 * Dimensions.widthUnit,
            vertical: 8 * Dimensions.heightUnit,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: getHeader(widget.cardType),
              ),
              AnimatedContainer(
                alignment: Alignment.centerLeft,
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.fromLTRB(0, 10 * Dimensions.heightUnit, 0, 0),
                height: expanded ? getExpandedHeight(widget.cardType) : 0,
                child: AnimatedOpacity(
                    opacity: expanded ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: ListView(
                      shrinkWrap: true,
                      children: getExtraInformation(widget.cardType),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.income} ${ledger.formatMonetaryAmounts(widget.income.perDayIncome, false, context)} / ${AppLocalizations.of(context)!.day}',
                    style: TextStyles.cardBody,
                  ),
                  RotatingButton(
                    iconData: Icons.arrow_drop_down,
                    milliseconds: 300,
                    onPressed: (bool newExpanded) {
                      setState(() {
                        expanded = newExpanded;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
