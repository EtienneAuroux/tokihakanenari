import 'package:flutter/material.dart';

class PassiveIncome extends StatefulWidget {
  const PassiveIncome({super.key});

  @override
  State<PassiveIncome> createState() => _PassiveIncomeState();
}

class _PassiveIncomeState extends State<PassiveIncome> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.green,
      child: Center(
        child: const Text(
          'test\ntest',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
