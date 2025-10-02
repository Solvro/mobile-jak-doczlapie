import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../stops/data/stop.dart";
import "../../stops/data/stops_repository.dart";

part "stop_repository.g.dart";

@riverpod
Future<Stop> stopRepository(Ref ref, int id) async {
  final stops = await ref.watch(stopsRepositoryProvider.future);
  return stops.firstWhere((stop) => id == stop.id);
}
