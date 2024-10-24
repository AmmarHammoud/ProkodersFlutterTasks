import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:prokoders_flutter_tasks/task_4_e_commerce/home_screen/home_screen.dart';
import 'package:prokoders_flutter_tasks/task_4_e_commerce/onboarding/footer/onboarding_footer.dart';
import 'package:prokoders_flutter_tasks/task_4_e_commerce/onboarding/footer/onboarding_footer_circle.dart';

import 'onboarding_item.dart';

class AppOnboarding extends StatelessWidget {
  const AppOnboarding({super.key});

  final String photoPrefix = 'assets/onboarding_photos';

  @override
  Widget build(BuildContext context) {
    List<Widget> onboardingFooterCircles = [
      const OnboardingFooterCircle(),
      const OnboardingFooterCircle(),
      const OnboardingFooterCircle(),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Onboarding(
            buildFooter: (context, netDragDistance, pagesLength, currentIndex,
                setIndex, slideDirection) {
              // return Text('$currentIndex');/

              onboardingFooterCircles = [
                const OnboardingFooterCircle(),
                const OnboardingFooterCircle(),
                const OnboardingFooterCircle(),
              ];

              onboardingFooterCircles[currentIndex] =
                  const OnboardingFooterCircle(
                isSelected: true,
              );

              return OnboardingFooter(
                onboardingFooterCircles: onboardingFooterCircles,
              );
            },
            swipeableBody: [
              OnboardingItem(
                description: 'this is the first onboarding item',
                imageLocation: '$photoPrefix/onboarding_photo_1.png',
              ),
              OnboardingItem(
                description: 'this is the second onboarding item',
                imageLocation: '$photoPrefix/onboarding_photo_2.png',
              ),
              OnboardingItem(
                description: 'this is the third onboarding item',
                imageLocation: '$photoPrefix/onboarding_photo_3.png',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(Icons.skip_next, size: 40)),
    );
  }
}
