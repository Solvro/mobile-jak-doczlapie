import "package:flutter/material.dart";
import "package:glass/glass.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/cards/blur_card.dart";
import "../../../config/sheet_config.dart";
import "../data/trip_repository.dart";
import "commute_section.dart";
import "final_section.dart";
import "handle.dart";
import "trip_header.dart";
import "trip_stop_tile.dart";
import "walk_section.dart";

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
        return BlurCard(
          borderRadius2: const BorderRadius.only(topLeft: Radius.circular(r31), topRight: Radius.circular(r31)),
          borderRadius: r31,
          child: CustomScrollView(
            controller: sheetScrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeaderDelegate(
                  size: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(p12),
                    child: Column(
                      children: [
                        const Handle(),
                        TripHeader(trip: trip),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(p16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return [
                      const WalkSection(address: "Wschowa, ul Walna", time: "10:10", distance: 420, duration: 5),
                      const SizedBox(height: p12),
                      const CommuteSection(),
                      const SizedBox(height: p8),
                      const FinalSection(),
                    ][index];
                  }, childCount: 5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
