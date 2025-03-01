import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(55.751244, 37.618423), // Центр карты (Москва)
          zoom: 10.0, // Уровень масштабирования
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'], // Поддомены для загрузки тайлов
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(55.751244, 37.618423), // Координаты маркера
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
    );
  }
}