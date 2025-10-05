import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:latlong2/latlong.dart";
import "../../../common/services/location_service.dart";

AsyncSnapshot<LatLng?> useCoords(String? address) {
  return useFuture(
    useMemoized(
      () => address?.isNotEmpty ?? false ? LocationService.getCoordinatesFromAddress(address!) : Future.value(),
      [address],
    ),
  );
}

AsyncSnapshot<String?> useAddress(LatLng? coords) {
  return useFuture(
    useMemoized(() => coords != null ? LocationService.getPlacemarkFromCoords(coords) : Future.value(), [coords]),
  );
}
