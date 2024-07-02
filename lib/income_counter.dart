import 'package:flutter/material.dart';

class IncomeCounter extends StatefulWidget {
  const IncomeCounter({super.key});

  @override
  State<IncomeCounter> createState() => _IncomeCounterState();
}

class _IncomeCounterState extends State<IncomeCounter> {
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
