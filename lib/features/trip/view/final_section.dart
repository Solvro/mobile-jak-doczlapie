import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../routes_list/view/route_chip.dart";
import "../../routes_map/data/route_response.dart";
import "walk_section.dart";

class FinalSection extends StatelessWidget {
  const FinalSection({super.key, required this.routePoint});
  final RouteStop routePoint;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: p8,
      children: [
        const SizedBox(width: p4),
        RouteChip(
          text: "${routePoint.time.split(":").first}:${routePoint.time.split(":")[1]}",
          style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
          color: RouteChipColor.green,
        ),
        AddresLabel(coordinates: routePoint.coordinates),
      ],
    );
  }
}
