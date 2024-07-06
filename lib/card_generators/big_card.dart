import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/large_card_clipper.dart';

import 'dart:developer' as developer;

class BigCard extends StatefulWidget {
  final CardType cardType;
  final void Function() onPanBigCardCorner;

  const BigCard({
    super.key,
    required this.cardType,
    required this.onPanBigCardCorner,
  });

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  Duration? panTimeStamp;
  double panDistance = 0;

  @override
  Widget build(BuildContext context) {
    Size bigCardSize = MediaQuery.of(context).size;
    double panLimit = sqrt(pow(bigCardSize.width / 4, 2) + pow(bigCardSize.height / 4, 2));

    return ClipPath(
      clipper: LargeCardClipper(),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.localPosition.dx < bigCardSize.width / 2 && details.localPosition.dy > bigCardSize.height / 2) {
            panDistance += details.delta.distance;
            if (panDistance > panLimit) {
              widget.onPanBigCardCorner();
            }
          }
        },
        onPanEnd: (details) {
          panDistance = 0;
        },
        child: Container(
          width: 100,
          height: 200,
          color: Colors.green,
        ),
      ),
    );
  }
}
