import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../routes_map/data/route_response.dart";
import "latlng_converter.dart";
import "line.dart";
import "schedule.dart";

part "stop.freezed.dart";
part "stop.g.dart";

@freezed
abstract class Stop with _$Stop {
  const factory Stop({
    required int id,
    required String name,
    required TransportType type,
    required int distance,
    @LatLngConverter() required LatLng coordinates,
    List<Line>? routes,
    List<Schedule>? schedules,
  }) = _Stop;

  factory Stop.fromJson(Map<String, dynamic> json) => _$StopFromJson(json);
}
