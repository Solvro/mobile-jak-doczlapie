import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../data/trip_repository.dart";

class RoutePolylineLayer extends HookWidget {
  const RoutePolylineLayer({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final routePoints = useMemoized(() => trip.stops.map((stop) => stop.coordinates).toList(), [trip.stops]);

    return PolylineLayer(
      polylines: [Polyline(points: routePoints, strokeWidth: p4, color: context.colorScheme.primary)],
    );
  }
}
