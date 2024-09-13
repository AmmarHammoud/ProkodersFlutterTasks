import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppController extends GetxController {
  ///A bool to determine if the current app's theme is dark
  late Rx<ThemeMode> themeMode;

  ///An object of Get storage to safe the current theme
  late GetStorage _storage;

  ///A method to determine the current theme
  ThemeMode getCurrentTheme() {
    var currentTheme = _storage.read('theme');
    if (currentTheme == null) return ThemeMode.system;
    return currentTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  void onInit() {
    _storage = GetStorage();
    themeMode = getCurrentTheme().obs;
    super.onInit();
  }

  ///A method to change and save the theme state
  void changeTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
      _storage.write('theme', 'light');
    } else {
      themeMode.value = ThemeMode.dark;
      _storage.write('theme', 'dark');
    }
  }
}
