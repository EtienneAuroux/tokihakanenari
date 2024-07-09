import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

class PrivateFunds extends StatefulWidget {
  final CardStatus cardStatus;

  const PrivateFunds({
    super.key,
    required this.cardStatus,
  });

  @override
  State<PrivateFunds> createState() => _PrivateFundsState();
}

class _PrivateFundsState extends State<PrivateFunds> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Private funds'),
    );
  }
}