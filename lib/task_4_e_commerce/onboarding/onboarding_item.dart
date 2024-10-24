import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.imageLocation,
    required this.description,
  });

  final String imageLocation;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageLocation,
          scale: 2,
        ),
        Text(description),
      ],
    );
  }
}
