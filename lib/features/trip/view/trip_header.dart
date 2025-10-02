import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../stops/view/line_chip.dart";
import "../data/trip.dart";

class TripHeader extends StatelessWidget {
  const TripHeader({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: p8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.directions_bus, size: p32),
        LineChip(lineNumber: trip.lineNumber),
        const Icon(Icons.arrow_forward, size: p16),
        Text(trip.direction, style: context.textTheme.bodyLarge),
      ],
    );
  }
}
