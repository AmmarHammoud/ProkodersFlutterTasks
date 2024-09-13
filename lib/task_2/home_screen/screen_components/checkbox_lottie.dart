import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/task_model.dart';
import '../logic/home_controller.dart';
import '../logic/tasks_animation_controller.dart';

class LottieCheckbox extends StatelessWidget {
  const LottieCheckbox({
    super.key,
    required this.todo,
    required this.homeController,
    required this.tasksAnimationControllers,
  });

  final Todo todo;
  final HomeController homeController;
  final TasksAnimationControllers tasksAnimationControllers;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        homeController.changeTaskState(todo);
      },
      child: Lottie.asset(
        width: 50,
        height: 50,
        'assets/lottie/checkbox_animation.json',
        controller: tasksAnimationControllers.doneController.value,
      ),
    );
  }
}
