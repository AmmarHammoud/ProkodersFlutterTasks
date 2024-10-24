import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/home_screen.dart';
import 'package:prokoders_flutter_tasks/task_3/logic/app_controller.dart';
import 'package:prokoders_flutter_tasks/task_4_e_commerce/onboarding/app_onboarding.dart';


void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appController =
  Get.put<AppController>(AppController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0x0014997f),
        ),
        useMaterial3: true,
      ),
      //darkTheme: ThemeData.dark(),
      themeMode: appController.themeMode.value,
      home: const AppOnboarding(),
    );
  }
}
