import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:image_picker/image_picker.dart";

class ImagePickerController {
  final ValueNotifier<XFile?> image;
  final Future<void> Function(ImageSource source) pickImage;
  final Future<void> Function() uploadImage;

  ImagePickerController({required this.image, required this.pickImage, required this.uploadImage});
}

ImagePickerController useImagePicker() {
  final image = useState<XFile?>(null);
  final picker = useMemoized(ImagePicker.new);

  Future<void> pick(ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      image.value = picked;
    }
  }

  Future<void> upload() async {
    if (image.value == null) return;

    // Implement actions
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  return ImagePickerController(image: image, pickImage: pick, uploadImage: upload);
}
