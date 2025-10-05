import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:image_picker/image_picker.dart";

class ImagePickerController {
  final ValueNotifier<XFile?> image;
  final ValueNotifier<String?> base64Image;
  final Future<void> Function(ImageSource source) pickImage;
  final Future<void> Function() uploadImage;

  ImagePickerController({
    required this.image,
    required this.base64Image,
    required this.pickImage,
    required this.uploadImage,
  });
}

ImagePickerController useImagePicker() {
  final image = useState<XFile?>(null);
  final base64Image = useState<String?>(null);
  final picker = useMemoized(ImagePicker.new);

  Future<void> pick(ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      image.value = picked;
      // Convert to base64 for cross-platform compatibility
      final bytes = await picked.readAsBytes();
      base64Image.value = base64Encode(bytes);
    }
  }

  Future<void> upload() async {
    if (image.value == null) return;

    // Implement actions
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  return ImagePickerController(image: image, base64Image: base64Image, pickImage: pick, uploadImage: upload);
}
