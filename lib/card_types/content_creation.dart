import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

class ContentCreation extends StatefulWidget {
  final CardStatus cardStatus;

  const ContentCreation({
    super.key,
    required this.cardStatus,
  });

  @override
  State<ContentCreation> createState() => _ContentCreationState();
}

class _ContentCreationState extends State<ContentCreation> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Content creation',
        style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),
      ),
    );
  }
}
