import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

class IndexFunds extends StatefulWidget {
  final CardStatus cardStatus;

  const IndexFunds({
    super.key,
    required this.cardStatus,
  });

  @override
  State<IndexFunds> createState() => _IndexFundsState();
}

class _IndexFundsState extends State<IndexFunds> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Private funds'),
    );
  }
}
