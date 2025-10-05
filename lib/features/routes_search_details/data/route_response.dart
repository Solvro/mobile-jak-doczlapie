import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../stops_map/data/latlng_converter.dart";

part "route_response.freezed.dart";
part "route_response.g.dart";

enum TransportType {
  @JsonValue("train")
  train,
  @JsonValue("bus")
  bus,
}

@freezed
abstract class RouteResponse with _$RouteResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RouteResponse({
    required RouteStop departure,
    required RouteStop arrival,
    required int travelTime,
    required int transfers,
    required List<Segment> routes, // segments
  }) = _RouteResponse;

  factory RouteResponse.fromJson(Map<String, dynamic> json) => _$RouteResponseFromJson(json);
}

@freezed
abstract class RouteStop with _$RouteStop {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RouteStop({
    required String name,
    required int id,
    @LatLngConverter() required LatLng coordinates,
    required String time,
    required int? distance,
  }) = _RouteStop;

  factory RouteStop.fromJson(Map<String, dynamic> json) => _$RouteStopFromJson(json);
}

@freezed
abstract class Segment with _$Segment {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Segment({
    required int id,
    required String name,
    required String operator,
    required TransportType type,
    required int run,
    @LatLngConverterNullable() LatLng? currentLocation,
    @LatLngConverterNullable() LatLng? delay,
    required RouteStop departure,
    required RouteStop arrival,
    required int travelTime,
    required String destination,
    required List<dynamic> reports,
  }) = _Segment;

  factory Segment.fromJson(Map<String, dynamic> json) => _$SegmentFromJson(json);
}
