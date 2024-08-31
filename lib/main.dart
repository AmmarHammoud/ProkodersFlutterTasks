import 'package:flutter/material.dart';
import 'package:prokoders_flutter_tasks/task_2/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0x0014997f),
          ),
          useMaterial3: true,
        ),
        home: HomeScreen());
  }
}
