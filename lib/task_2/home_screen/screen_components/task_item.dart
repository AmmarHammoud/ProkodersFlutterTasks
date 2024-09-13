import 'package:flutter/material.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/screen_components/checkbox_lottie.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/screen_components/delete_lottie.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/screen_components/edit_lottie.dart';
import '../../models/task_model.dart';
import '../logic/home_controller.dart';
import '../logic/tasks_animation_controller.dart';
import 'package:get/get.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                LottieCheckbox(
                    todo: todo,
                    homeController: homeController,
                    tasksAnimationControllers: tasksAnimationControllers),
                Expanded(
                  child: Obx(
                    () {
                      Offset begin = tasksAnimationControllers
                              .editReversing.value
                          ? const Offset(0, 0)
                          : Offset(
                              (-screenWidth * 0.012) / todo.title.length, 0);
                      Offset end = tasksAnimationControllers.editReversing.value
                          ? Offset(
                              (-screenWidth * 0.012) / todo.title.length, 0)
                          : const Offset(0, 0);

                      return AnimatedOpacity(
                        opacity: tasksAnimationControllers.opacity.value,
                        duration: const Duration(milliseconds: 350),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: begin,
                            end: end,
                          ).animate(
                              tasksAnimationControllers.titleController.value),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                  width: screenWidth,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.05,
                                      bottom: screenHeight * 0.05,
                                      left: screenWidth * 0.05,
                                      right: screenWidth * 0.05,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          todo.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),
                                        Text(todo.body),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.done
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationThickness: 3.0,
                                decorationColor: Colors.greenAccent[200],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              LottieEditButton(
                  todo: todo,
                  homeController: homeController,
                  tasksAnimationControllers: tasksAnimationControllers),
              LottieDeleteButton(
                  todo: todo,
                  homeController: homeController,
                  tasksAnimationControllers: tasksAnimationControllers),
            ],
          ),
        ],
      ),
    );
  }
}
