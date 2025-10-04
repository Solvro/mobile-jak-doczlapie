import "package:latlong2/latlong.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../stops_map/data/rest_client.dart";
import "../../stops_map/data/schedule.dart";
part "trip_repository.g.dart";

typedef TripStop = ({LatLng coordinates, String name, String time});

typedef Trip = ({List<TripStop> stops, String name, String direction, int run, String lineId});
@riverpod
Future<Trip> tripRepository(Ref ref, String lineId, int runId, String direction) async {
  final client = ref.watch(restClientProvider);
  final line = await client.getLine(lineId);

  final List<TripStop> stops =
      line.stops
          ?.map(
            (stop) => (
              coordinates: stop.coordinates,
              name: stop.name,
              time:
                  List<Schedule?>.from(
                    stop.schedules ?? [],
                  ).firstWhere((schedule) => schedule?.run == runId, orElse: () => null)?.time ??
                  "UNKOWN",
            ),
          )
          .toList() ??
      [];
  return (stops: stops, name: line.name, direction: direction, run: runId, lineId: lineId);
}
