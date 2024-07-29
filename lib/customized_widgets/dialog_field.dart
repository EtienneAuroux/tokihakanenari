import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class DialogField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? inputType;

  const DialogField({
    super.key,
    required this.controller,
    this.inputType,
  });

  @override
  State<DialogField> createState() => _DialogFieldState();
}

class _DialogFieldState extends State<DialogField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textAlign: TextAlign.center,
      style: TextStyles.dialogText,
      keyboardType: widget.inputType,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 7),
        isCollapsed: true,
      ),
    );
  }
}
