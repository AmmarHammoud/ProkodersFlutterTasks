import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/logic/home_controller.dart';

class AnimatedFloatingActionButton extends StatelessWidget {
  AnimatedFloatingActionButton({super.key, required this.onPressed});

  final Duration duration = const Duration(milliseconds: 300);
  final Function() onPressed;

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AnimatedSlide(
          duration: duration,
          offset:
              homeController.showFab.value ? Offset.zero : const Offset(0, 2),
          child: AnimatedOpacity(
            duration: duration,
            opacity: homeController.showFab.value ? 1 : 0,
            child: FloatingActionButton(
              onPressed: onPressed,
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
