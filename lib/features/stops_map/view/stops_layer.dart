import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../data/stop.dart";

class StopMarkersLayer extends HookWidget {
  const StopMarkersLayer({super.key, required this.stops, this.onMarkerTap, this.activeStop});

  final List<Stop> stops;
  final void Function(int index)? onMarkerTap;
  final Stop? activeStop;
  @override
  Widget build(BuildContext context) {
    final markers = stops.asMap().entries.map((entry) {
      final index = entry.key;
      final stop = entry.value;

      return Marker(
        point: stop.coordinates,
        width: activeStop == stop ? p24 : p20,
        height: activeStop == stop ? p24 : p20,
        child: GestureDetector(
          onTap: switch (onMarkerTap) {
            null => null,
            final fn => () => fn(index),
          },
          child: DotIndicator(variant: activeStop == stop ? DotIndicatorVariant.red : DotIndicatorVariant.blue),
        ),
      );
    }).toList();

    return MarkerLayer(markers: markers);
  }
}
