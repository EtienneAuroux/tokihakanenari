import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final CardPosition previousCardPosition;
  final CardPosition newCardPosition;
  final Widget cardContent;

  const CustomCard({super.key, required this.previousCardPosition, required this.newCardPosition, required this.cardContent});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  Size cardSize(Size deviceSize, Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.landscape) {
      return Size(deviceSize.width * 0.5, deviceSize.height * 0.7);
    } else {
      return Size(deviceSize.width * 0.7, deviceSize.height * 0.4);
    }
  }

  double cardRotation(CardPosition cardPosition) {
    switch (cardPosition) {
      case CardPosition.goneUp:
        return -pi / 2;
      case CardPosition.previous:
        return -pi / 4;
      case CardPosition.current:
        return 0;
      case CardPosition.next:
        return pi / 4;
      case CardPosition.goneDown:
        return pi / 2;
    }
  }

  @override
  void initState() {
    super.initState();
    developer.log('previous: ${widget.previousCardPosition.name}, new: ${widget.newCardPosition}');
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    Size deviceSize = queryData.size;
    Orientation deviceOrientation = queryData.orientation;

    return Container(
      alignment: Alignment.center,
      child: Card(
        child: Container(
          width: cardSize(deviceSize, deviceOrientation).width,
          height: cardSize(deviceSize, deviceOrientation).height,
          child: widget.cardContent,
        ),
      ),
    );
  }
}

enum CardPosition { goneUp, previous, current, next, goneDown }
