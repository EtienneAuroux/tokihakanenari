import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

// import 'dart:developer' as developer;

class DangerDialog extends StatefulWidget {
  final String title;
  final void Function() onActionValidated;

  const DangerDialog({
    super.key,
    required this.title,
    required this.onActionValidated,
  });

  @override
  State<DangerDialog> createState() => _DangerDialogState();
}

class _DangerDialogState extends State<DangerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyles.dialogTitle,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesome5.exclamation_triangle),
              Flexible(
                child: Text(
                  'This action cannot be undone!',
                  style: TextStyles.dialogText,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          TextField(
            textAlign: TextAlign.center,
            style: TextStyles.dialogText,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 7),
              isCollapsed: true,
              hintText: 'Type "Okame" to delete',
            ),
            onChanged: (String value) {
              if (value == 'Okame') {
                widget.onActionValidated();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
