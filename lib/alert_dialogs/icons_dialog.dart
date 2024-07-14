import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';

class IconsDialog extends StatefulWidget {
  final CardType cardType;
  final void Function(IconData) onIconChosenCallback;

  const IconsDialog({
    super.key,
    required this.cardType,
    required this.onIconChosenCallback,
  });

  @override
  State<IconsDialog> createState() => _IconsDialogState();
}

class _IconsDialogState extends State<IconsDialog> {
  final List<IconData> icons = <IconData>[
    Icons.abc,
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: DecoratedBox(
        decoration: CardDecoration.getMiniDecoration(widget.cardType),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: List.generate(
            icons.length,
            (index) => IconButton(
              onPressed: () {
                widget.onIconChosenCallback(icons[index]);
                Navigator.of(context).pop();
              },
              icon: Icon(icons[index]),
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
