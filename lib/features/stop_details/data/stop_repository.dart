import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../stops_map/data/rest_client.dart";
import "../../stops_map/data/stop.dart";

part "stop_repository.g.dart";

@riverpod
Future<Stop> stopRepository(Ref ref, String id) async {
  final client = ref.watch(restClientProvider);
  final stop = await client.getStopDetails(id);
  return stop;
}
