import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/rotating_button.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

// import 'dart:developer' as developer;

class SettingContainer extends StatefulWidget {
  final String title;
  final int milliseconds;
  final List<Widget> children;
  final bool open;
  final void Function(bool) onOpen;
  final Color? borderColor;

  const SettingContainer({
    super.key,
    required this.title,
    required this.milliseconds,
    required this.children,
    required this.open,
    required this.onOpen,
    this.borderColor,
  });

  @override
  State<SettingContainer> createState() => _SettingContainerState();
}

class _SettingContainerState extends State<SettingContainer> {
  bool expanded = false;
  late Color borderColor;

  @override
  void initState() {
    super.initState();

    borderColor = widget.borderColor ?? Colors.black.withAlpha(50);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.milliseconds),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 1,
          ),
          left: BorderSide(
            color: borderColor,
            width: 1,
          ),
          bottom: BorderSide(
            color: borderColor,
            width: 4,
          ),
          right: BorderSide(
            color: borderColor,
            width: 4,
          ),
        ),
      ),
      padding: const EdgeInsets.all(5),
      height: widget.open ? 490 : 110,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyles.settingTitle,
              ),
              RotatingButton(
                iconData: Icons.arrow_drop_down,
                milliseconds: widget.milliseconds,
                onPressed: (bool newExpanded) {
                  widget.onOpen(newExpanded);
                },
                forcedReverse: !widget.open,
              )
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: widget.children,
            ),
          )
        ],
      ),
    );
  }
}
