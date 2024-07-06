import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/large_card_clipper.dart';

class BigCard extends StatefulWidget {
  final CardType cardType;

  const BigCard({
    super.key,
    required this.cardType,
  });

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LargeCardClipper(),
      child: Container(
        width: 100,
        height: 200,
        color: Colors.green,
      ),
    );
  }
}
