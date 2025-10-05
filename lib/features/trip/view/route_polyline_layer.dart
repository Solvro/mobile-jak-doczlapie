import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/tokens.dart";
import "../../routes_map/data/route_response.dart";

class RoutePolylineLayer extends HookWidget {
  const RoutePolylineLayer({super.key, required this.route});

  final RouteResponse route;

  @override
  Widget build(BuildContext context) {
    final routePoints = useMemoized(() => route.routes.map((stop) => stop.departure.coordinates).toList(), [
      route.routes,
    ]);

    return PolylineLayer(
      polylines: [Polyline(points: routePoints, strokeWidth: p4, color: blueColorNew)],
    );
  }
}
