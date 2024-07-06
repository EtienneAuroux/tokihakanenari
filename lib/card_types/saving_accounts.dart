import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

class SavingAccounts extends StatefulWidget {
  final CardStatus cardStatus;

  const SavingAccounts({
    super.key,
    required this.cardStatus,
  });

  @override
  State<SavingAccounts> createState() => _SavingAccountsState();
}

class _SavingAccountsState extends State<SavingAccounts> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Saving accounts'),
    );
  }
}
