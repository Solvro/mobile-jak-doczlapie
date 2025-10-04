import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../stops_map/data/latlng_converter.dart";

part "track_response.g.dart";
part "track_response.freezed.dart";

@freezed
abstract class TrackResponse with _$TrackResponse {
  const factory TrackResponse({required int run, @LatLngConverter() required LatLng coordinates}) = _TrackResponse;

  factory TrackResponse.fromJson(Map<String, dynamic> json) => _$TrackResponseFromJson(json);
}
