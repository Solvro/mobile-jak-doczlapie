import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/tokens.dart";
import "../../trip/data/trip_repository.dart";
import "stop_detail_view.dart";

class LinePolylineLayer extends HookConsumerWidget {
  const LinePolylineLayer({super.key, required this.line});

  final LineWithDestination? line;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trip = ref.watch(
      tripRepositoryProvider(
        line?.line.id.toString() ?? "",
        line?.line.schedules?.first.run ?? 0,
        line?.destination ?? "",
      ),
    );

    return switch (trip) {
      AsyncData(:final value) => Stack(
        children: [
          PolylineLayer(
            polylines: [
              Polyline(
                points: (value.stops..sort((a, b) => a.sequence.compareTo(b.sequence)))
                    .map((stop) => stop.coordinates)
                    .toList(),
                strokeWidth: p4,
                color: blueColorNew,
              ),
            ],
          ),
          // TODO add back
          // StopMarkersLayer(route: value),
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
