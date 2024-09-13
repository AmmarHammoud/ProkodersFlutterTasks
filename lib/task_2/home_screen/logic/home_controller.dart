import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prokoders_flutter_tasks/task_2/components/toast.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/logic/tasks_animation_controller.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/screen_components/task_item.dart';
import '../../models/task_model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  ///An object of Get storage
  late GetStorage storage;

  ///A list to hold todos
  late RxList<Todo> tasks;

  ///A list that holds the animation controllers of adding, editing, and deleting tasks
  late RxList<TasksAnimationControllers> taskAnimationController;

  ///A controller that holds the text of the title of the todo
  late Rx<TextEditingController> titleController;

  ///A controller that holds the text of the body of the todo
  late Rx<TextEditingController> bodyController;

  ///A list to observe and modify the animation of todos list
  late final Rx<GlobalKey<AnimatedListState>> listKey;

  ///A bool to control the visibility of Floating Action Button
  late Rx<bool> showFab;

  ///Overriding [onInit] method to initialize the variables
  @override
  void onInit() {
    storage = GetStorage();
    tasks = <Todo>[].obs;
    titleController = TextEditingController().obs;
    bodyController = TextEditingController().obs;
    listKey = GlobalKey<AnimatedListState>().obs;
    taskAnimationController = <TasksAnimationControllers>[].obs;
    showFab = true.obs;
    super.onInit();
  }

  ///Override [onReady] method in fetch the stored note once the controller has been initialized
  @override
  void onReady() {
    fetchTasks();
    super.onReady();
  }

  ///A method to fetch data from Get storage
  void fetchTasks() async {
    var t = storage.read('tasks');
    if (t == null) return;
    for (var e in t) {
      tasks.add(Todo.fromJson(e));
      listKey.value.currentState?.insertItem(
          tasks.length - 1 < 0 ? 0 : tasks.length - 1,
          duration: const Duration(milliseconds: 150));
      taskAnimationController.add(TasksAnimationControllers());
      //taskAnimationController[index].doneController.value.animateTo(0.5);
      if (tasks.elementAt(tasks.length - 1).done) {
        taskAnimationController
            .elementAt(taskAnimationController.length - 1)
            .doneController
            .value
            .animateTo(0.5);
      }
      await Future.delayed(
        const Duration(milliseconds: 200),
        () {
          taskAnimationController
              .elementAt(taskAnimationController.length - 1)
              .titleController
              .value
              .forward();

          taskAnimationController
              .elementAt(taskAnimationController.length - 1)
              .opacity
              .value = 1.0;

          taskAnimationController.refresh();
        },
      );
    }
  }

  ///A method to store data in Get storage
  void updateStorageTasks() {
    storage.write('tasks', tasks);
  }

  ///A method to add a new unique task.
  ///It updates the screen by updating [tasks].
  ///It prevents adding the same task twice, and adding a task with empty title.
  ///It requires [context] in order to display a toast with error message (if any).
  addTask({
    required BuildContext context,
    required String todoTitle,
    required String todoBody,
  }) async {
    if (todoTitle.isEmpty) {
      showToast(
          context: context,
          text: 'Cannot add an empty task',
          color: Colors.red);
      titleController.value.clear();
      return;
    }

    for (var todo in tasks) {
      if (todo.title == todoTitle) {
        showToast(
          context: context,
          text: 'this task is already exists',
          color: Colors.red,
        );
        titleController.value.clear();
        bodyController.value.clear();
        return;
      }
    }

    Todo todo = Todo(title: todoTitle, body: todoBody);
    tasks.add(todo);
    updateStorageTasks();
    taskAnimationController.add(TasksAnimationControllers());

    listKey.value.currentState?.insertItem(
        tasks.length - 1 < 0 ? 0 : tasks.length - 1,
        duration: const Duration(milliseconds: 750));

    await Future.delayed(
      const Duration(milliseconds: 850),
      () {
        taskAnimationController
            .elementAt(taskAnimationController.length - 1)
            .titleController
            .value
            .forward();

        taskAnimationController
            .elementAt(taskAnimationController.length - 1)
            .opacity
            .value = 1.0;

        taskAnimationController.refresh();
      },
    );

    titleController.value.clear();
    bodyController.value.clear();
  }

  ///A method to handle done animation.
  ///The json animation consists of two parts, the animation, and the reversed animation
  ///so, if the task is not done, animate the half of the animation, otherwise, reverse it.
  void _forwardDoneController(int index, Todo todo) {
    if (!todo.done) {
      taskAnimationController[index].doneController.value.animateTo(0);
    } else {
      taskAnimationController[index].doneController.value.animateTo(0.5);
    }
  }

  ///A helper method to find the index of a todo.
  int _findTodoIndex(Todo todo) {
    int desiredTodoIndex = tasks.indexWhere((e) {
      return e.title == todo.title;
    });
    return desiredTodoIndex;
  }

  ///A method to change the status of current todo.
  ///It firstly retrieve the index of the current todo, change its status, and trigger the animation.
  changeTaskState(Todo todo) {
    int desiredTodoIndex = _findTodoIndex(todo);
    tasks[desiredTodoIndex].done = !tasks[desiredTodoIndex].done;
    tasks.refresh();
    _forwardDoneController(desiredTodoIndex, tasks[desiredTodoIndex]);
    updateStorageTasks();
  }

  ///A method to delete a todo.
  ///It firstly retrieve the index of the current todo, updates the screen, and then delete the todo and its animations controller
  deleteTask(Todo todo) {
    int desiredIndex = _findTodoIndex(todo);

    listKey.value.currentState?.removeItem(
      desiredIndex,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: TaskItem(
            tasksAnimationControllers: TasksAnimationControllers(),
            todo: todo,
            homeController: this,
          ),
        );
      },
    );

    taskAnimationController.removeAt(desiredIndex);
    tasks.removeAt(desiredIndex);
    updateStorageTasks();
  }

  ///A method to edit a task.
  ///It firstly retrieve the index of the current todo, animate the old title out of the screen
  ///then animate the new title to the screen
  editTask(Todo todo) async {
    int desiredIndex = _findTodoIndex(todo);

    taskAnimationController[desiredIndex].titleController.value.forward();
    taskAnimationController[desiredIndex].opacity.value = 0.0;

    await Future.delayed(const Duration(milliseconds: 500));

    taskAnimationController[desiredIndex].editReversing.value = true;

    taskAnimationController[desiredIndex].titleController.value.reverse();

    taskAnimationController[desiredIndex].opacity.value = 1.0;

    tasks[desiredIndex].title = titleController.value.text;
    tasks[desiredIndex].body = bodyController.value.text;

    titleController.value.clear();
    bodyController.value.clear();
    tasks.refresh();
    taskAnimationController.refresh();
  }

  ///A method to toggle the Visibility of the floating action button
  void toggleFab() {
    showFab.value = !showFab.value;
  }
}
