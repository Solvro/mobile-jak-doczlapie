import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../../routes_map/data/route_response.dart";

class RoutePolylineLayer extends HookWidget {
  const RoutePolylineLayer({super.key, required this.route});

  final RouteResponse route;

  @override
  Widget build(BuildContext context) {
    final routePoints = [
      ...route.routes.map((segment) => segment.departure.coordinates),
      route.routes.last.arrival.coordinates,
    ];

    return Stack(
      children: [
        PolylineLayer(
          polylines: [Polyline(points: routePoints, strokeWidth: p4, color: blueColorNew)],
        ),
        MarkerLayer(
          markers: [
            if (routePoints.isNotEmpty) ...[
              Marker(
                point: routePoints.first,
                width: p12,
                height: p12,
                child: const DotIndicator(variant: DotIndicatorVariant.red),
              ),
              Marker(
                point: routePoints.last,
                width: p12,
                height: p12,
                child: const DotIndicator(variant: DotIndicatorVariant.green),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
