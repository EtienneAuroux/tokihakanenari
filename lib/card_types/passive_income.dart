import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

class PassiveIncome extends StatefulWidget {
  final CardStatus cardStatus;

  const PassiveIncome({
    super.key,
    required this.cardStatus,
  });

  @override
  State<PassiveIncome> createState() => _PassiveIncomeState();
}

class _PassiveIncomeState extends State<PassiveIncome> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Passive income',
        style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),
      ),
    );
  }
}
