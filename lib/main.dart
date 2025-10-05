import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:intl/date_symbol_data_local.dart";

import "app/app.dart";
import "common/services/mapbox_geocoding.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("PL_pl");

  final service = MapboxGeocoding();
  final searchResult = await service.getCoordsFromAddress("Kraków, Polska");
  debugPrint("Mapbox $searchResult");

  final address = await service.getAddressFromCoords(searchResult!);

  debugPrint("Mapbox $address");

  runApp(ProviderScope(child: App()));
}
