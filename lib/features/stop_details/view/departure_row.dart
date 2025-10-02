import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/tokens.dart";
import "../../../utils/format_time.dart";
import "../hooks/use_sorted_departures.dart";

class DepartureRow extends StatelessWidget {
  const DepartureRow({required this.departure, required this.lineNumber});
  final String lineNumber;
  final DepartureWithDirection departure;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.router.push(TripRoute(lineNumber: lineNumber, startingDeparture: departure)),
      leading: const Icon(Icons.directions_bus, size: p16),
      title: Row(spacing: p8, children: [Text(formatTime(departure.departure.timestamp)), Text(departure.direction)]),
    );
  }
}
