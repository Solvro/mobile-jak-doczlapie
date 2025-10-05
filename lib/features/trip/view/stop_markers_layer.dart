import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../data/trip_repository.dart";

class StopMarkersLayer extends HookWidget {
  const StopMarkersLayer({super.key, required this.trip, this.onMarkerTap});

  final Trip trip;
  final void Function(int index)? onMarkerTap;

  @override
  Widget build(BuildContext context) {
    final markers = [
      ...trip.stops.asMap().entries.map((entry) {
        final index = entry.key;
        final stop = entry.value;

        return Marker(
          point: stop.coordinates,
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
