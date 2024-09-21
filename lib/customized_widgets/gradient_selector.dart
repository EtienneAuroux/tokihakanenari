import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/color_picker_dialog.dart';
import 'package:tokihakanenari/ledger_data/color_gradient.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class GradientSelector extends StatefulWidget {
  final String title;
  final CardType? cardType;

  const GradientSelector({
    super.key,
    required this.title,
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

    ledger.addListener(() {
      if (mounted) {
        setState(() {
          colorGradient = ledger.getCardGradient(widget.cardType);
        });
      }
    });
  }

  @override
  void dispose() {
    ledger.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5 * Dimensions.heightUnit),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200 * Dimensions.widthUnit,
            child: Text(
              '${widget.title}:',
              style: TextStyles.cardBody,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ColorPickerDialog(
                      cardType: widget.cardType,
                      originalColors: ledger.getCardGradient(widget.cardType),
                      onNewColors: (List<Color> newColors) {
                        ledger.setCardGradient(widget.cardType, newColors.first, newColors.last);
                        setState(() {});
                      },
                    );
                  });
            },
            child: Container(
              width: 120 * Dimensions.widthUnit,
              height: 39 * Dimensions.heightUnit,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorGradient.bottom, colorGradient.topRight],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10 * Dimensions.heightUnit)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
