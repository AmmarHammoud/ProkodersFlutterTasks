import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/task_model.dart';
import '../logic/home_controller.dart';
import '../logic/tasks_animation_controller.dart';

class LottieDeleteButton extends StatelessWidget {
  const LottieDeleteButton({
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
      onTap: () async {
        homeController.titleController.value.clear();
        tasksAnimationControllers.deleteController.value.forward();
        await Future.delayed(
            tasksAnimationControllers.deleteController.value.duration!);
        tasksAnimationControllers.deleteController.value.reverse();
        homeController.deleteTask(todo);
      },
      child: Lottie.asset(
        width: 35,
        height: 35,
        'assets/lottie/delete_animation.json',
        controller: tasksAnimationControllers.deleteController.value,
      ),
    );
  }
}
