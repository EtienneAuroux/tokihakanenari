import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class DialogEntry extends StatefulWidget {
  final String entry;
  final String hint;

  const DialogEntry({
    super.key,
    required this.entry,
    required this.hint,
  });

  @override
  State<DialogEntry> createState() => _DialogEntryState();
}

class _DialogEntryState extends State<DialogEntry> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Tooltip(
        message: widget.hint,
        child: Text(
          '${widget.entry}:',
          style: TextStyles.dialogText,
        ),
      ),
    );
  }
}
