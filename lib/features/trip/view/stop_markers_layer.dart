import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../data/trip_repository.dart";

class StopMarkersLayer extends HookWidget {
  const StopMarkersLayer({super.key, required this.trip, this.onMarkerTap});

  final Trip trip;
  final void Function(int index)? onMarkerTap;

  @override
  Widget build(BuildContext context) {
    final markers = useMemoized(
      () => trip.stops.asMap().entries.map((entry) {
        final index = entry.key;
        final stop = entry.value;

        return Marker(
          point: stop.coordinates,
          width: p64,
          height: p64,
          child: GestureDetector(
            onTap: switch (onMarkerTap) {
              null => null,
              final fn => () => fn(index),
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: context.colorScheme.onPrimary, width: p4),
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: context.textTheme.bodyMedium?.withColor(context.colorScheme.onPrimary),
                ),
              ),
            ),
          ),
        );
      }).toList(),
      [trip.stops],
    );

    return MarkerLayer(markers: markers);
  }
}
