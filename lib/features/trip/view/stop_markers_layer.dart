import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../../routes_map/data/route_response.dart";

class StopMarkersLayer extends HookWidget {
  const StopMarkersLayer({super.key, required this.route, this.onMarkerTap});

  final RouteResponse route;
  final void Function(int index)? onMarkerTap;

  @override
  Widget build(BuildContext context) {
    final markers = [
      ...route.routes.asMap().entries.skip(1).map((entry) {
        final index = entry.key;
        final stop = entry.value;

        return Marker(
          point: stop.arrival.coordinates,
          width: p12,
          height: p12,
          child: GestureDetector(
            onTap: switch (onMarkerTap) {
              null => null,
              final fn => () => fn(index),
            },
            child: const DotIndicator(variant: DotIndicatorVariant.blue),
          ),
        );
      }),
    ];

    return MarkerLayer(markers: markers);
  }
}
