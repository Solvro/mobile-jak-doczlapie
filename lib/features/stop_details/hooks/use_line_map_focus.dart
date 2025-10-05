import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:latlong2/latlong.dart";

import "../../stops_map/data/line.dart";
import "../../trip/data/trip_repository.dart";

typedef LineWithDestination = ({Line line, String destination});

/// Hook for focusing the map on a line when it changes
///
/// Automatically calculates bounds from trip stops and focuses the map
/// to show the entire line route with padding.
void useLineMapFocus({
  required ValueNotifier<LineWithDestination?> activeLine,
  required MapController mapController,
  required WidgetRef ref,
}) {
  useEffect(() {
    if (activeLine.value != null) {
      final line = activeLine.value!;
      final tripAsync = ref.read(
        tripRepositoryProvider(line.line.id.toString(), line.line.schedules?.first.run ?? 0, line.destination),
      );

      tripAsync.when(
        data: (tripData) {
          if (tripData.stops.isNotEmpty) {
            final coordinates = tripData.stops.map((stop) => stop.coordinates).toList();
            final bounds = _calculateBounds(coordinates);
            mapController.fitCamera(CameraFit.bounds(bounds: bounds));
          }
        },
        loading: () {},
        error: (_, _) {},
      );
    }
    return null;
  }, [activeLine.value]);
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
  const paddingDegrees = 0.08;

  return LatLngBounds(
    LatLng(minLat - paddingDegrees, minLng - paddingDegrees),
    LatLng(maxLat + paddingDegrees, maxLng + paddingDegrees),
  );
}
