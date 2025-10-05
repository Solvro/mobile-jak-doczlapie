import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

import "../data/route_response.dart";

/// Hook for focusing the map on a route when it changes
///
/// Automatically calculates bounds from route coordinates and focuses the map
/// to show the entire route with padding.
void useRouteMapFocus({required ValueNotifier<RouteResponse?> activeRoute, required MapController mapController}) {
  useEffect(() {
    if (activeRoute.value != null) {
      final route = activeRoute.value!;
      final coordinates = [
        route.departure.coordinates,
        ...route.routes.map((segment) => segment.departure.coordinates),
        route.arrival.coordinates,
      ];

      if (coordinates.isNotEmpty) {
        final bounds = _calculateBounds(coordinates);
        mapController.fitCamera(CameraFit.bounds(bounds: bounds));
      }
    }
    return null;
  }, [activeRoute.value]);
}

/// Calculate bounds from a list of coordinates with padding
LatLngBounds _calculateBounds(List<LatLng> coordinates) {
  if (coordinates.isEmpty) {
    return LatLngBounds(
      const LatLng(50.0645, 19.9830), // Default to Tauron Arena
      const LatLng(50.0645, 19.9830),
    );
  }

  double minLat = coordinates.first.latitude;
  double maxLat = coordinates.first.latitude;
  double minLng = coordinates.first.longitude;
  double maxLng = coordinates.first.longitude;

  for (final coord in coordinates) {
    minLat = minLat < coord.latitude ? minLat : coord.latitude;
    maxLat = maxLat > coord.latitude ? maxLat : coord.latitude;
    minLng = minLng < coord.longitude ? minLng : coord.longitude;
    maxLng = maxLng > coord.longitude ? maxLng : coord.longitude;
  }

  // Add padding to bounds
  const paddingDegrees = 0.25;

  return LatLngBounds(
    LatLng(minLat - paddingDegrees, minLng - paddingDegrees),
    LatLng(maxLat + paddingDegrees, maxLng + paddingDegrees),
  );
}
