import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'camera_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  LatLng? _currentLocation; // Текущие координаты пользователя
  final MapController _mapController = MapController(); // Контроллер карты

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Получаем текущее местоположение при запуске экрана
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Проверяем разрешения на доступ к геолокации
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Службы геолокации отключены.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Разрешение на доступ к геолокации отклонено.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Разрешение на доступ к геолокации отклонено навсегда.');
      }

      // Получаем текущие координаты
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      // Перемещаем карту к текущему местоположению
      _mapController.move(_currentLocation!, 15.0);
    } catch (e) {
      print('Ошибка при получении местоположения: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Карта
          FlutterMap(
            mapController: _mapController, // Подключаем контроллер карты
            options: MapOptions(
              center: _currentLocation ?? LatLng(55.751244, 37.618423), // Центр карты
              zoom: 15.0, // Уровень масштабирования
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'], // Поддомены для загрузки тайлов
              ),
              // Маркер с текущим местоположением
              if (_currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!, // Координаты маркера
                      builder: (context) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          // Иконка с логотипом в правом верхнем углу
          Positioned(
            top: 40, // Отступ сверху
            right: 20, // Отступ справа
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8), // Серый цвет с прозрачностью 80%
                shape: BoxShape.circle, // Округлая форма
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Image.asset('assets/logo.png'), // логотип
                iconSize: 30,
                onPressed: () {
                  // Переход на второй экран
                  Navigator.pushNamed(context, '/map');
                },
              ),
            ),
          ),
        ],
      ),
      // Кнопка с иконкой плюса внизу по центру
      floatingActionButton: SizedBox(
        width: 72, // Увеличиваем ширину в 1.5 раза (стандартный размер 48)
        height: 72, // Увеличиваем высоту в 1.5 раза (стандартный размер 48)
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScreen()),
            );
          },
          backgroundColor: Colors.grey.withOpacity(0.8), // Серый цвет с прозрачностью 80%
          elevation: 4, // Тень кнопки
          child: const Icon(
            Icons.add,
            size: 36, // Увеличиваем размер иконки
            color: Colors.white, // Белый цвет иконки
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Позиция кнопки
    );
  }
}