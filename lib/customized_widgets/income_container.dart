import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/rotating_button.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'dart:developer' as developer;

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
  bool expanded = false;
  final BorderSide borderSide = BorderSide(
    color: Colors.black.withAlpha(50),
    width: 4,
  );

  List<Widget> getHeader(CardType cardType) {
    if (widget.cardType == CardType.contentCreation || widget.cardType == CardType.realEstate) {
      return [
        Text(
          widget.income.id,
          style: TextStyles.cardBody,
        ),
      ];
    } else {
      return [
        Icon(widget.income.icon),
        const SizedBox(
          width: 20,
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
          'revenue: ${widget.income.revenue} / ${widget.income.timePeriod!.name}',
          style: TextStyles.incomeExtraInformation,
        ),
      ];
    } else if (cardType == CardType.customIncome) {
      return [
        Text(
          'investment: ${widget.income.amount}',
          style: TextStyles.incomeExtraInformation,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'average return: ${widget.income.interest!.toStringAsFixed(2)} % / year',
          style: TextStyles.incomeExtraInformation,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'generated revenue: ${widget.income.revenue} / year',
          style: TextStyles.incomeExtraInformation,
        )
      ];
    } else if (cardType == CardType.realEstate) {
      return [
        Text(
          'description: ${widget.income.description}',
          style: TextStyles.incomeExtraInformation,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'capital: ${widget.income.amount}',
          style: TextStyles.incomeExtraInformation,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'appreciation: ${widget.income.interest} % / year',
          style: TextStyles.incomeExtraInformation,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'monthly payment: ${widget.income.payment}',
          style: TextStyles.incomeExtraInformation,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'generated revenue: ${widget.income.revenue} / year',
          style: TextStyles.incomeExtraInformation,
        )
      ];
    } else {
      return [
        Text(
          'investment: ${widget.income.amount!.round()}',
          style: TextStyles.incomeExtraInformation,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'average return: ${widget.income.interest!.toStringAsFixed(2)} % / year',
          style: TextStyles.incomeExtraInformation,
        ),
      ];
    }
  }

  double getExpandedHeight(CardType cardType) {
    if (cardType == CardType.contentCreation || cardType == CardType.salaries) {
      return 30;
    } else if (cardType == CardType.customIncome) {
      return 90;
    } else if (cardType == CardType.realEstate) {
      return 120;
    } else {
      return 60;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: borderSide,
          right: borderSide,
        ),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.red, Colors.red.withAlpha(0)],
          begin: Alignment.centerLeft,
          end: Alignment(widget.gradientEnd, 0),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
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
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                'income: ${widget.income.perDayIncome.toStringAsFixed(2)} / day',
                style: TextStyles.cardBody,
              ),
              RotatingButton(
                iconData: Icons.arrow_drop_down,
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
    );
  }
}
