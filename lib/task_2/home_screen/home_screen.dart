import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/logic/home_controller.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/screen_components/bottom_sheet.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/screen_components/task_item.dart';
import 'package:prokoders_flutter_tasks/task_3/components/animated_floating_action_button.dart';
import 'package:prokoders_flutter_tasks/task_3/components/toggle_theme_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Task Manager App'),
        actions: [
          ToggleThemeButton(),
        ],
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final ScrollDirection direction = notification.direction;
          if (direction == ScrollDirection.reverse) {
            homeController.showFab.value = false;
          } else if (direction == ScrollDirection.forward) {
            homeController.showFab.value = true;
          }
          return true;
        },
        child: Obx(
          () {
            if (homeController.tasks.isEmpty) {
              return const Center(
                child: Text('No tasks'),
              );
            }
            return AnimatedList(
              physics: const BouncingScrollPhysics(),
              key: homeController.listKey.value,
              initialItemCount: homeController.tasks.length,
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  sizeFactor: CurvedAnimation(
                      parent: animation, curve: Curves.decelerate),
                  child: TaskItem(
                    tasksAnimationControllers:
                        homeController.taskAnimationController[index],
                    todo: homeController.tasks[index],
                    homeController: homeController,
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        onPressed: () {
          homeController.titleController.value.clear();
          homeController.bodyController.value.clear();
          bottomSheet(
            titleController: homeController.titleController.value,
            bodyController: homeController.bodyController.value,
            context: context,
            text: 'please enter the details',
            onPressed: () {
              homeController.addTask(
                context: context,
                todoTitle: homeController.titleController.value.text,
                todoBody: homeController.bodyController.value.text,
              );
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
