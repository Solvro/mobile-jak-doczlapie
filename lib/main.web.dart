import "package:device_preview/device_preview.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:intl/date_symbol_data_local.dart";
import "app/app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("PL_pl");
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Center(
                child: DeviceFrame(device: Devices.ios.iPhone13ProMax, screen: App()),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
