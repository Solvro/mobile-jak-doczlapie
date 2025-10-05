import "package:latlong2/latlong.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../routes_map/data/route_response.dart";
import "../../stops_map/data/rest_client.dart";
import "../../stops_map/data/schedule.dart";
part "trip_repository.g.dart";

typedef TripStop = ({LatLng coordinates, String name, String time, int sequence});

typedef Trip = ({
  String id,
  List<TripStop> stops,
  String name,
  String direction,
  int run,
  String lineId,
  TransportType type,
  String operator,
});

@riverpod
Future<Trip> tripRepository(Ref ref, String lineId, int runId, String direction) async {
  final client = ref.watch(restClientProvider);
  final line = await client.getLine(lineId);

  final List<TripStop> stops =
      line.stops?.map((stop) {
        final schedule = List<Schedule?>.from(
          stop.schedules ?? [],
        ).firstWhere((schedule) => schedule?.run == runId, orElse: () => null);
        return (
          coordinates: stop.coordinates,
          name: stop.name,
          time: schedule?.time ?? "UNKOWN",
          sequence: schedule?.sequence ?? 0,
        );
      }).toList() ??
      [];
  return (
    id: line.id.toString(),
    stops: stops,
    name: line.name,
    direction: direction,
    run: runId,
    lineId: lineId,
    type: line.type,
    operator: line.operator,
  );
}
