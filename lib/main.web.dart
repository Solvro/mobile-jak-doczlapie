import "package:device_preview/device_preview.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "app/app.dart";

void main() {
  runApp(DevicePreview(builder: (context) => ProviderScope(child: App())));
}
