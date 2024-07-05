import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_decoration.dart';

class CustomCard extends StatefulWidget {
  final CardType cardType;
  final Widget cardContent;
  final Function(bool) callback;

  const CustomCard({
    super.key,
    required this.cardType,
    required this.cardContent,
    required this.callback,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  late CardDecoration cardDecoration;

  Size cardSize(Size deviceSize, Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.landscape) {
      return Size(deviceSize.width * 0.6, deviceSize.height * 0.8);
    } else {
      return Size(deviceSize.width * 0.8, deviceSize.height * 0.6);
    }
  }

  @override
  void initState() {
    super.initState();

    cardDecoration = CardDecoration(widget.cardType);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    Size deviceSize = queryData.size;
    Orientation deviceOrientation = queryData.orientation;

    return Container(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: cardDecoration.boxDecoration,
          width: cardSize(deviceSize, deviceOrientation).width,
          height: cardSize(deviceSize, deviceOrientation).height,
          child: InkWell(
            splashColor: cardDecoration.splashColor,
            onLongPress: () {
              developer.log('longpress');
            },
            onTap: () {
              developer.log('tap');
              widget.callback(true);
            },
            child: widget.cardContent,
          ),
        ),
      ),
    );
  }
}
