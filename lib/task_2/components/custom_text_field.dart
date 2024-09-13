import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.hasNext = true,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool hasNext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      autofocus: true,
      textInputAction: hasNext ? TextInputAction.next : TextInputAction.done,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
