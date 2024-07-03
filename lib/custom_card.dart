import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Widget cardContent;

  const CustomCard({super.key, required this.cardContent});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  Size cardSize(Size deviceSize, Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.landscape) {
      return Size(deviceSize.width * 0.5, deviceSize.height * 0.7);
    } else {
      return Size(deviceSize.width * 0.8, deviceSize.height * 0.6);
    }
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
