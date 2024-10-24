import 'package:flutter/material.dart';
import 'package:prokoders_flutter_tasks/task_4_e_commerce/onboarding/footer/onboarding_footer_circle.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.onboardingFooterCircles,
  });

  final List<Widget> onboardingFooterCircles;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: onboardingFooterCircles,
    );
  }
}
