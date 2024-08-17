import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SwitchWithText extends StatefulWidget {
  SwitchWithText(
      {super.key,
        required this.value,
        required this.text,
        this.activeColor = Colors.green,
        this.inactiveColor = Colors.white,
        this.inactiveSwitchBorder = Colors.grey,
        this.inactiveSwitchBorderSize = 2.0,
        this.inactiveToggleBorder = Colors.grey,
        this.inactiveToggleBorderSize = 2.0,
        this.onChanged});

  final String text;
  bool value;
  final Color activeColor;
  final Color inactiveColor;
  final Color inactiveToggleBorder;
  final double inactiveToggleBorderSize;
  final Color inactiveSwitchBorder;
  final double inactiveSwitchBorderSize;

  //final VoidCallback? onChanged;
  final ValueChanged<bool>? onChanged;

  @override
  State<SwitchWithText> createState() => _SwitchWithTextState();
}

class _SwitchWithTextState extends State<SwitchWithText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.text),
        FlutterSwitch(
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
            toggleSize: 15,
            inactiveToggleBorder: Border.all(
              color: widget.inactiveToggleBorder,
              width: widget.inactiveToggleBorderSize,
            ),
            inactiveSwitchBorder: Border.all(
              color: widget.inactiveSwitchBorder,
              width: widget.inactiveSwitchBorderSize,
            ),
            height: 25,
            width: 60,
            value: widget.value,
            onToggle: (bool v) {
              setState(() {
                widget.value = v;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(
                    v); // Call the onChanged callback with the new value
              }
            })
      ],
    );
  }
}
