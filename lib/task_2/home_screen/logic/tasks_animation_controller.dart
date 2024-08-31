import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksAnimationControllers extends GetxController
    with GetTickerProviderStateMixin {
  ///Animation controller to assign an animation to every todo.
  late Rx<AnimationController> doneController;
  late Rx<AnimationController> editController;
  late Rx<AnimationController> deleteController;
  late Rx<AnimationController> titleController;

  ///Animation type and curve.
  late Rx<Animation<double>> titleAnimation;

  ///to hold the value of title opacity when triggering the animation.
  late Rx<double> opacity;

  ///to decide whether the title is being edited or not.
  late Rx<bool> editReversing;

  TasksAnimationControllers() {
    editReversing = false.obs;

    doneController = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1500),
            reverseDuration: const Duration(seconds: 0))
        .obs;
    editController = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1500),
            reverseDuration: const Duration(seconds: 0))
        .obs;
    deleteController = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1500),
            reverseDuration: const Duration(seconds: 0))
        .obs;
    titleController = AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300))
        .obs;

    titleAnimation = CurvedAnimation(
      parent: titleController.value,
      curve: Curves.easeOut,
    ).obs;

    opacity = 0.0.obs;
  }

  @override
  void dispose() {
    doneController.value.dispose();
    editController.value.dispose();
    deleteController.value.dispose();
    super.dispose();
  }
}
