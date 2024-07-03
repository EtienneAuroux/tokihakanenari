import 'package:flutter/material.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.add_rounded,
        size: 100,
      ),
    );
  }
}
