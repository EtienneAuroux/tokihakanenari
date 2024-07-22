import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/rotating_button.dart';
import 'package:tokihakanenari/ledger_data/income.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'dart:developer' as developer;

class IncomeContainer extends StatefulWidget {
  final Income income;
  final double gradientEnd;

  const IncomeContainer({
    super.key,
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
        horizontal: 5,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: expanded ? 100 : 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(widget.income.icon),
                    Text(
                      widget.income.id,
                      style: TextStyles.dialogTitle,
                    ),
                    Text(
                      '${widget.income.perDayIncome.toStringAsFixed(2)} / day',
                      style: TextStyles.dialogTitle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          RotatingButton(
            iconData: Icons.arrow_drop_down,
            onPressed: (bool newExpanded) {
              setState(() {
                expanded = newExpanded;
              });
            },
          )
        ],
      ),
    );
  }
}
