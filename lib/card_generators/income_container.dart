import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/income.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.red, Colors.red.withAlpha(0)],
          begin: Alignment.centerLeft,
          end: Alignment(widget.gradientEnd, 0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      // child: widget.cardItems[index],
      child: Column(),
    );
  }
}
