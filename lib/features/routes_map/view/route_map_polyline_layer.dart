import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:latlong2/latlong.dart";

import "../../../app/tokens.dart";
import "../data/route_response.dart";
import "route_stops_layer.dart";

class RouteMapPolylineLayer extends HookConsumerWidget {
  const RouteMapPolylineLayer({super.key, required this.route});

  final RouteResponse? route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routePoints = [
      ...(route?.routes.map((segment) => segment.departure.coordinates).toList() ?? []),
      route?.arrival.coordinates ?? const LatLng(0, 0),
    ];
    return Stack(
      children: [
        PolylineLayer(
          polylines: [
            Polyline(
              points: routePoints.map((stop) => LatLng(stop.latitude, stop.longitude)).toList(),
              strokeWidth: p4,
              color: blueColorNew,
            ),
          ],
        ),
        if (route != null) RouteStopsLayer(route: route!),
      ],
    );
  }
}
