import "package:flutter/material.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/cards/blur_card.dart";
import "../../../config/sheet_config.dart";
import "../../routes_map/data/route_response.dart";
import "commute_section.dart";
import "final_section.dart";
import "handle.dart";
import "trip_header.dart";
import "walk_section.dart";

class TripBottomSheet extends StatelessWidget {
  const TripBottomSheet({super.key, required this.route, required this.onStopTap, this.draggableController});

  final RouteResponse route;
  final void Function(int index) onStopTap;
  final DraggableScrollableController? draggableController;

  @override
  Widget build(BuildContext context) {
    final children = [
      if (route.departure.distance != 0) WalkSection(routeStop: route.departure),
      const SizedBox(height: p12),
      ...route.routes.map((segment) => CommuteSection(segment: segment, isTrain: segment.type == TransportType.train)),
      const SizedBox(height: p8),
      if (route.arrival.distance != 0) WalkSection(routeStop: route.arrival, name: route.routes.last.arrival.name),
      FinalSection(routePoint: route.arrival),
    ];
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
                  size: 165,
                  child: Padding(
                    padding: const EdgeInsets.all(p12),
                    child: Column(
                      children: [
                        const Handle(),
                        TripHeader(route: route),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(p16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return children[index];
                  }, childCount: children.length),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
