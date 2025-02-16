import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Логотип в белой окружности
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                icon: Image.asset('assets/logo.png'), // логотип
                iconSize: 40,
                onPressed: () {
                  // Переход на второй экран
                  Navigator.pushNamed(context, '/second');
                },
              ),
            ),
            const SizedBox(height: 20), // Отступ между логотипом и текстом
            // Название приложения
            const Text(
              'kak pogodka',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40), // Отступ между текстом и иконками
            // Иконки социальных сетей
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Иконка VK
                IconButton(
                  icon: Image.asset('assets/icons/vk.png'), // Добавьте иконку VK в assets
                  iconSize: 40,
                  onPressed: () {
                    // Переход на второй экран
                    Navigator.pushNamed(context, '/second');
                  },
                ),
                const SizedBox(width: 20), // Отступ между иконками
                // Иконка Google
                IconButton(
                  icon: Image.asset('assets/icons/google.png'), // Добавьте иконку Google в assets
                  iconSize: 40,
                  onPressed: () {
                    // Переход на второй экран
                    Navigator.pushNamed(context, '/second');
                  },
                ),
                const SizedBox(width: 20), // Отступ между иконками
                // Иконка Yandex
                IconButton(
                  icon: Image.asset('assets/icons/ya.png'), // Добавьте иконку Yandex в assets
                  iconSize: 40,
                  onPressed: () {
                    // Переход на второй экран
                    Navigator.pushNamed(context, '/second');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}