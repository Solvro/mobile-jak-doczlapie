import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "stop_detail_view.dart";

class LinePolylineLayer extends HookWidget {
  const LinePolylineLayer({super.key, required this.line});

  final LineWithDestination? line;

  @override
  Widget build(BuildContext context) {
    // todo: make a fetch
    final routePoints = switch (line?.line.stops) {
      null || [] => <LatLng>[],
      final stops => stops.map((stop) => stop.coordinates).toList(),
    };

    if (routePoints.isEmpty) {
      return const SizedBox.shrink();
    }

    return PolylineLayer(
      polylines: [Polyline(points: routePoints, strokeWidth: p4, color: context.colorScheme.primary)],
    );
  }
}
