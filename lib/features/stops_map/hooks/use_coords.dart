import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:latlong2/latlong.dart";

import "../../../common/services/mapbox_geocoding.dart";

final mapboxService = MapboxGeocoding();

AsyncSnapshot<LatLng?> useCoords(String? address) {
  return useFuture(
    useMemoized(() => address?.isNotEmpty ?? false ? mapboxService.getCoordsFromAddress(address!) : Future.value(), [
      address,
    ]),
  );
}

AsyncSnapshot<String?> useAddress(LatLng? coords) {
  return useFuture(
    useMemoized(() => coords != null ? mapboxService.getAddressFromCoords(coords) : Future.value(), [coords]),
  );
}
