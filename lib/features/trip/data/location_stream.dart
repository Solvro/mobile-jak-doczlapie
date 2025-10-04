import "package:latlong2/latlong.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../common/services/location_service.dart";

part "location_stream.g.dart";

@riverpod
Stream<LatLng> locationStream(Ref ref) {
  return LocationService.getLocationStream();
}
