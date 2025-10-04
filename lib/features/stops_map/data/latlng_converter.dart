import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json["latitude"] as double, json["longitude"] as double);
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {"latitude": object.latitude, "longitude": object.longitude};
  }
}
