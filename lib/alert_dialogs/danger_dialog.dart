import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesome5.exclamation_triangle),
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.warningMessage,
                  style: TextStyles.dialogText,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          TextField(
            textAlign: TextAlign.center,
            style: TextStyles.dialogText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
              isCollapsed: true,
              hintText: AppLocalizations.of(context)!.typeOkameDelete,
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
