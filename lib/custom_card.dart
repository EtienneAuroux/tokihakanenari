import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Size deviceSize;
  final Orientation deviceOrientation;
  final Widget cardContent;

  const CustomCard({super.key, required this.deviceSize, required this.deviceOrientation, required this.cardContent});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  Size cardSize() {
    if (widget.deviceOrientation == Orientation.landscape) {
      return Size(widget.deviceSize.width * 0.5, widget.deviceSize.height * 0.7);
    } else {
      return Size(widget.deviceSize.width * 0.7, widget.deviceSize.height * 0.4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        child: Container(
          width: cardSize().width,
          height: cardSize().height,
          child: widget.cardContent,
        ),
      ),
    );
  }
}
