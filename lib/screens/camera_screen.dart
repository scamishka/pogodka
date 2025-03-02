import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _isFrontCamera = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = _isFrontCamera ? cameras.last : cameras.first;

      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      // Инициализация Future
      _initializeControllerFuture = _cameraController.initialize();
      await _initializeControllerFuture; // Дожидаемся завершения инициализации
      setState(() {});
    } catch (e) {
      print('Ошибка при инициализации камеры: $e');
    }
  }

  Future<void> _toggleCamera() async {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    await _cameraController.dispose();
    await _initializeCamera(); // Переинициализация камеры
  }

  Future<void> _toggleFlash() async {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    await _cameraController.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  Future<void> _takePhoto() async {
    try {
      // Убедимся, что камера инициализирована
      await _initializeControllerFuture;

      // Создаем фотографию
      final image = await _cameraController.takePicture();
      print('Фото сохранено: ${image.path}');
    } catch (e) {
      print('Ошибка при создании фото: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(_cameraController),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20), // Отступы по бокам
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Иконка включения вспышки
                        IconButton(
                          onPressed: _toggleFlash,
                          icon: Icon(
                            _isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        // Кнопка создания фотографии
                        // Новая кнопка создания фотографии
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: _takePhoto, // Обработчик нажатия
                            borderRadius: BorderRadius.circular(35), // Радиус окружности
                          ),
                        ),
                        // Иконка переключения на фронтальную камеру
                        IconButton(
                          onPressed: _toggleCamera,
                          icon: const Icon(
                            Icons.cameraswitch,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}