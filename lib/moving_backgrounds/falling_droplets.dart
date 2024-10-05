import 'package:flutter/material.dart';

class FallingDroplets extends StatefulWidget {
  final List<Color> colors;
  final Widget child;

  const FallingDroplets({
    super.key,
    required this.colors,
    required this.child,
  });

  @override
  State<FallingDroplets> createState() => _FallingDropletsState();
}

class _FallingDropletsState extends State<FallingDroplets> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
