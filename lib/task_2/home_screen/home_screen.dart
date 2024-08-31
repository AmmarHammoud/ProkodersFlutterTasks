import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/logic/home_controller.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/logic/tasks_animation_controller.dart';
import '../models/task_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Task Manager App'),
      ),
      body: Obx(
        () {
          return AnimatedList(
              key: homeController.listKey.value,
              initialItemCount: homeController.tasks.length,
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  //sizeFactor: animation,
                  sizeFactor: CurvedAnimation(
                      parent: animation, curve: Curves.decelerate),

                  // position: animation.drive(
                  //   Tween<Offset>(
                  //     begin: const Offset(0, -1), // Slide from the right
                  //     end: const Offset(0, 0), // Slide to its final position
                  //   ).chain(
                  //     CurveTween(curve: Curves.ease),
                  //   ),
                  // ),
                  child: TaskItem(
                      tasksAnimationControllers:
                          homeController.taskAnimationController[index],
                      todo: homeController.tasks[index],
                      homeController: homeController),
                );
              });

          // return ListView.separated(
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) => TaskItem(tasksAnimationControllers: TasksAnimationControllers(),
          //         todo: homeController.tasks[index],
          //         homeController: homeController),
          //     separatorBuilder: (context, index) => SizedBox(
          //           height: screenHeight * 0.001,
          //         ),
          //     itemCount: homeController.tasks.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheet(
            titleController: homeController.titleController.value,
            context: context,
            text: 'please enter the title',
            onPressed: () {
              homeController.addTask(
                  context: context,
                  todoTitle: homeController.titleController.value.text);
              Navigator.pop(context);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    homeController.changeTaskState(todo);
                  },
                  child: Lottie.asset(
                    width: 50,
                    height: 50,
                    'assets/lottie/checkbox_animation.json',
                    controller: tasksAnimationControllers.doneController.value,
                  ),
                ),

                // IconButton(
                //   onPressed: () {
                //     homeController.changeTaskState(todo);
                //   },
                //   icon: todo.done
                //       ? const Icon(
                //           Icons.check_box,
                //           color: Colors.green,
                //         )
                //       : const Icon(Icons.square_outlined),
                // ),

                //Expanded(child: Text(todo.title, overflow: TextOverflow.ellipsis,)),

                //SizedBox(width: screenWidth * 0.05,),

                Expanded(
                  child: Obx(() {
                    Offset begin = tasksAnimationControllers.editReversing.value
                        ? Offset(0, 0)
                        : Offset((-screenWidth * 0.012) / todo.title.length, 0);
                    Offset end = tasksAnimationControllers.editReversing.value
                        ? Offset((-screenWidth * 0.012) / todo.title.length, 0)
                        : Offset(0, 0);

                    return AnimatedOpacity(
                      opacity: tasksAnimationControllers.opacity.value,
                      duration: const Duration(milliseconds: 350),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          // begin: Offset(
                          //     (-screenWidth * 0.012) / todo.title.length,
                          //     tasksAnimationControllers.by.value),
                          // end: Offset(0, tasksAnimationControllers.ey.value),
                          begin: begin,
                          end: end,
                        ).animate(
                            tasksAnimationControllers.titleController.value),
                        child: Text(
                          todo.title,
                          style: TextStyle(
                            decoration:
                                todo.done ? TextDecoration.lineThrough : null,
                            decorationThickness: 3.0,
                            decorationColor: Colors.greenAccent[200],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // IconButton(
              //     onPressed: () {
              //       homeController.titleController.value.text = todo.title;
              //       bottomSheet(
              //           titleController: homeController.titleController.value,
              //           context: context,
              //           text: 'edit the title',
              //           onPressed: () {
              //             homeController.editTask(todo);
              //             Navigator.pop(context);
              //           });
              //     },
              //     icon: const Icon(Icons.edit)),
              // IconButton(
              //     onPressed: () {
              //       homeController.titleController.value.clear();
              //       homeController.deleteTask(todo);
              //     },
              //     icon: const Icon(Icons.delete_forever_sharp)),

              InkWell(
                onTap: () async {
                  homeController.titleController.value.text = todo.title;
                  tasksAnimationControllers.editController.value.forward();
                  await Future.delayed(
                      tasksAnimationControllers.editController.value.duration!);
                  tasksAnimationControllers.editController.value.reverse();
                  bottomSheet(
                      titleController: homeController.titleController.value,
                      context: context,
                      text: 'edit the title',
                      onPressed: () {
                        homeController.editTask(todo);
                        Navigator.pop(context);
                      });
                },
                child: Lottie.asset(
                  width: 50,
                  height: 50,
                  'assets/lottie/edit_animation.json',
                  controller: tasksAnimationControllers.editController.value,
                ),
              ),
              InkWell(
                onTap: () async {
                  homeController.titleController.value.clear();
                  tasksAnimationControllers.deleteController.value.forward();
                  await Future.delayed(tasksAnimationControllers
                      .deleteController.value.duration!);
                  tasksAnimationControllers.deleteController.value.reverse();
                  homeController.deleteTask(todo);
                },
                child: Lottie.asset(
                  width: 35,
                  height: 35,
                  'assets/lottie/delete_animation.json',
                  controller: tasksAnimationControllers.deleteController.value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget bottomSheet(
    {required context,
    required String text,
    required TextEditingController titleController,
    required Function()? onPressed}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              Text(text),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'taks title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  //prefixIcon: Icon(icon),
                  prefixIcon: const Icon(Icons.task),
                ),
              ),
              ElevatedButton(onPressed: onPressed, child: const Text('OK'))
            ],
          ),
        ),
      );
    },
  );
  return Container();
}
