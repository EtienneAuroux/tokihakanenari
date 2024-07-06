import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

class MiniCard extends StatefulWidget {
  final CardType cardType;

  const MiniCard({
    super.key,
    required this.cardType,
  });

  @override
  State<MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<MiniCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
