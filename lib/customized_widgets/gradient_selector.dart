import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/color_picker_dialog.dart';
import 'package:tokihakanenari/ledger_data/color_gradient.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';

class GradientSelector extends StatefulWidget {
  final CardType? cardType;

  const GradientSelector({
    super.key,
    this.cardType,
  });

  @override
  State<GradientSelector> createState() => _GradientSelectorState();
}

class _GradientSelectorState extends State<GradientSelector> {
  Ledger ledger = Ledger();
  late ColorGradient colorGradient;

  @override
  void initState() {
    super.initState();

    colorGradient = ledger.getCardGradient(widget.cardType);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ColorPickerDialog(
                  originalColors: ledger.getCardGradient(widget.cardType),
                  onNewColors: (List<Color> newColors) {
                    ledger.setCardGradient(widget.cardType, newColors.first, newColors.last);
                    setState(() {});
                  },
                );
              });
        },
        child: Ink(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorGradient.bottom, colorGradient.topRight],
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
