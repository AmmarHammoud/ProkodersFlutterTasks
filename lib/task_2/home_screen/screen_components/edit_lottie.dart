import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/task_model.dart';
import '../logic/home_controller.dart';
import '../logic/tasks_animation_controller.dart';
import 'bottom_sheet.dart';

class LottieEditButton extends StatelessWidget {
  const LottieEditButton({
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
        homeController.titleController.value.text = todo.title;
        homeController.bodyController.value.text = todo.body;
        tasksAnimationControllers.editController.value.forward();
        await Future.delayed(
            tasksAnimationControllers.editController.value.duration!);
        tasksAnimationControllers.editController.value.reverse();
        bottomSheet(
          titleController: homeController.titleController.value,
          bodyController: homeController.bodyController.value,
          context: context,
          text: 'edit the title',
          onPressed: () {
            homeController.editTask(todo);
            Navigator.pop(context);
          },
        );
      },
      child: Lottie.asset(
        width: 50,
        height: 50,
        'assets/lottie/edit_animation.json',
        controller: tasksAnimationControllers.editController.value,
      ),
    );
  }
}
