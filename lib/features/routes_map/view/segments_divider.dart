import "package:flutter/material.dart";

import "../../../app/tokens.dart";
import "../data/route_response.dart";

class SegmentsDivider extends StatelessWidget {
  const SegmentsDivider({super.key, required this.route});

  final RouteResponse route;

  @override
  Widget build(BuildContext context) {
    if (route.routes.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 2,
      width: double.infinity,
      child: Row(
        spacing: 1,
        children: route.routes.map((segment) {
          final isTrain = segment.type == TransportType.train;
          final segmentDuration = segment.travelTime;
          final proportion = route.travelTime > 0 ? segmentDuration / route.travelTime : 1.0 / route.routes.length;

          return Expanded(
            flex: (proportion * 100).round(),
            child: Container(
              height: 4,
              decoration: BoxDecoration(color: isTrain ? orange : red2, borderRadius: BorderRadius.circular(2)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
