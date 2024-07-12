import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/icons_dialog.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';

class AddNewDialog extends StatefulWidget {
  final CardType cardType;

  const AddNewDialog({
    super.key,
    required this.cardType,
  });

  @override
  State<AddNewDialog> createState() => _AddNewDialogState();
}

class _AddNewDialogState extends State<AddNewDialog> {
  IconData icon = Icons.abc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: DecoratedBox(
        decoration: CardDecoration.getMiniDecoration(CardType.savingAccounts),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('test'),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return IconsDialog(
                          cardType: widget.cardType,
                          onIconChosenCallback: (newIcon) {
                            setState(() {
                              icon = newIcon;
                            });
                          },
                        );
                      });
                },
                icon: Icon(icon)),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
