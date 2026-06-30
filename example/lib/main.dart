import 'package:flutter/material.dart';
import 'package:image_capture_field/image_capture_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Initializer(),
    );
  }
}

class Initializer extends StatelessWidget {
  Initializer({super.key});

  final _defaultController = ImageCaptureController();
  final _customController = ImageCaptureController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Image Capture Field'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade50,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              // Section 1: Default layout
              Text(
                'Default Layout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
              ),
              const SizedBox(height: 8),
              const Text(
                'This displays the built-in default UI with camera picker sheet and cropper.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              ImageCaptureField(
                controller: _defaultController,
                includeCropper: true,
                width: 180,
                height: 180,
                onImagePathChanged: (path) {
                  debugPrint('Default PATH: $path');
                },
                iconCamera: Icons.camera,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint('Default Name: ${_defaultController.imageName}');
                  debugPrint('Default isBlank: ${_defaultController.isBlank}');
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('Default Info'),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 24.0), child: Divider()),

              // Section 2: Custom Builder Layout
              Text(
                'Custom Builder Layout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
              ),
              const SizedBox(height: 8),
              const Text(
                'This uses placeholderBuilder and imageBuilder to override the UI entirely while reusing the underlying picker logic.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              ImageCaptureField(
                controller: _customController,
                includeCropper: true,
                onImagePathChanged: (path) {
                  debugPrint('Custom PATH: $path');
                },
                placeholderBuilder: (context, pickImage) {
                  return GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.teal.withValues(alpha: 0.04),
                        border: Border.all(color: Colors.teal.shade300, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.teal.shade700),
                          const SizedBox(height: 8),
                          Text(
                            'Upload Photo',
                            style: TextStyle(
                              color: Colors.teal.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Click to select or capture',
                            style: TextStyle(color: Colors.teal.shade500, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                imageBuilder: (context, imageData, pickImage, clearImage) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: Image.memory(imageData, fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: clearImage,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Icon(Icons.delete, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          bottom: 12,
                          right: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Photo captured!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.edit, color: Colors.white, size: 13),
                                      SizedBox(width: 4),
                                      Text('Change', style: TextStyle(color: Colors.white, fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint('Custom Name: ${_customController.imageName}');
                  debugPrint('Custom isBlank: ${_customController.isBlank}');
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('Custom Info'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
