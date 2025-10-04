import "package:riverpod_annotation/riverpod_annotation.dart";

import "rest_client.dart";
import "stop.dart";

part "stops_repository.g.dart";

@riverpod
Future<List<Stop>> stopsRepository(Ref ref, ({String latitude, String longitiude})? coords) async {
  if (coords == null) {
    return [];
  }
  final response = await ref.read(restClientProvider).getNearbyStops(coords.latitude, coords.longitiude, "10000");
  return response;
}
