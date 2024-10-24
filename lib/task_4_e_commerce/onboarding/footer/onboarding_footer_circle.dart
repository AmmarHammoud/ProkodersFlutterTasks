import 'package:flutter/material.dart';

class OnboardingFooterCircle extends StatelessWidget {
  const OnboardingFooterCircle({
    super.key,
    this.isSelected = false,
    this.size = 12,
  });

  final bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Icon(
            Icons.circle,
            size: size,
          )
        : Icon(
            Icons.circle_outlined,
            size: size,
          );
  }
}
