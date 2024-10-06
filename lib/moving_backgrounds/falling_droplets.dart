import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/water_drop.dart';

class FallingDroplets extends StatefulWidget {
  const FallingDroplets({
    super.key,
  });

  @override
  State<FallingDroplets> createState() => _FallingDropletsState();
}

class _FallingDropletsState extends State<FallingDroplets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WaterDrop(
        top: 100,
        left: 100,
        width: 150,
        height: 150,
      ),
    );
  }
}
