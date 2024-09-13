import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../logic/app_controller.dart';

class ToggleThemeButton extends StatelessWidget {
  ToggleThemeButton({super.key});

  final appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    bool value;
    if (appController.themeMode.value != ThemeMode.system) {
      value = appController.themeMode.value == ThemeMode.dark;
    } else {
      value = Theme.of(context).brightness == Brightness.dark;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlutterSwitch(
        activeIcon: const Icon(Icons.nightlight_round),
        activeColor: Colors.green,
        inactiveIcon: const Icon(Icons.wb_sunny),
        value: value,
        onToggle: (value) {
          appController.changeTheme();
          Get.changeThemeMode(appController.themeMode.value);
        },
      ),
    );
  }
}
