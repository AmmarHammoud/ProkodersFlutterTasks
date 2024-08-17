import 'package:flutter/material.dart';

class SettingItemComponent extends StatelessWidget {
  const SettingItemComponent(
      {super.key,
      required this.text,
      this.containsSuffix = false,
      required this.onTap});

  final String text;
  final bool containsSuffix;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (containsSuffix)
                const Icon(
                  Icons.add,
                  size: 18,
                ),
              Text(text),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 17,
          ),
        ],
      ),
    );
  }
}
