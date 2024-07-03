import 'package:flutter/material.dart';

class PassiveIncome extends StatefulWidget {
  const PassiveIncome({super.key});

  @override
  State<PassiveIncome> createState() => _PassiveIncomeState();
}

class _PassiveIncomeState extends State<PassiveIncome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('passive'),
    );
  }
}
