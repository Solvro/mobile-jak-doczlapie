import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../data/route_response.dart";

class RouteStopsLayer extends HookWidget {
  const RouteStopsLayer({super.key, required this.route, this.onMarkerTap});

  final RouteResponse route;
  final void Function(int index)? onMarkerTap;

  @override
  Widget build(BuildContext context) {
    final markers = useMemoized(
      () => [
        Marker(
          point: route.departure.coordinates,
          width: p12,
          height: p12,
          child: const DotIndicator(variant: DotIndicatorVariant.green),
        ),
        ...route.routes.asMap().entries.map((entry) {
          final index = entry.key;
          final segment = entry.value;

          return Marker(
            point: segment.departure.coordinates,
            width: p12,
            height: p12,
            child: GestureDetector(
              onTap: switch (onMarkerTap) {
                null => null,
                final fn => () => fn(index),
              },
              child: const DotIndicator(variant: DotIndicatorVariant.red),
            ),
          );
        }),
        Marker(
          point: route.arrival.coordinates,
          width: p12,
          height: p12,
          child: const DotIndicator(variant: DotIndicatorVariant.green),
        ),
      ],
      [route.routes],
    );

    return MarkerLayer(markers: markers);
  }
}
