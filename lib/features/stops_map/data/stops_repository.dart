import "package:riverpod_annotation/riverpod_annotation.dart";

import "rest_client.dart";
import "stop.dart";

part "stops_repository.g.dart";

@riverpod
Future<List<Stop>?> stopsRepository(Ref ref, ({String latitude, String longitiude})? coords) async {
  if (coords == null) {
    return null;
  }

  // Start with radius 1000 and increase step by step
  const initialRadius = 1000;
  const radiusStep = 1000;
  const maxRadius = 10000; // Maximum radius to prevent infinite loops

  for (var radius = initialRadius; radius <= maxRadius; radius += radiusStep) {
    final response = await ref
        .read(restClientProvider)
        .getNearbyStops(coords.latitude, coords.longitiude, radius.toString());

    // If we found stops, return them
    if (response.isNotEmpty) {
      return response;
    }
  }

  // If no stops found with any radius, return null
  return [];
}
