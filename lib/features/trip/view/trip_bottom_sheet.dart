import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../config/sheet_config.dart";
import "../data/trip.dart";
import "handle.dart";
import "trip_header.dart";
import "trip_stop_tile.dart";

class TripBottomSheet extends StatelessWidget {
  const TripBottomSheet({super.key, required this.trip, required this.onStopTap, this.draggableController});

  final Trip trip;
  final void Function(int index) onStopTap;
  final DraggableScrollableController? draggableController;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: defaultSheetConfig.baseSize,
      minChildSize: defaultSheetConfig.minSize,
      maxChildSize: defaultSheetConfig.maxSize,
      controller: draggableController,
      builder: (context, sheetScrollController) {
        return DecoratedBox(
          decoration: BoxDecoration(color: context.colorScheme.surface),
          child: CustomScrollView(
            controller: sheetScrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeaderDelegate(
                  size: defaultSheetConfig.headerHeight,
                  child: Column(
                    children: [
                      const Handle(),
                      TripHeader(trip: trip),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final stop = trip.stops[index];
                  return TripStopTile(stop: stop, onStopTap: onStopTap, index: index);
                }, childCount: trip.stops.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
