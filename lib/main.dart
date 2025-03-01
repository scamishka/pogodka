import 'package:flutter/material.dart';
import 'screens/first_screen.dart'; // Первый экран
import 'screens/second_screen.dart'; // Второй экран
import 'screens/camera_screen.dart'; // Экран с камерой

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Приложение pogodka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(), // Первый экран как стартовый
      routes: {
        '/map': (context) => const SecondScreen(), // Маршрут для второго экрана
        '/camera': (context) => const CameraScreen(), // Маршрут для экрана с камерой
      },
    );
  }
}