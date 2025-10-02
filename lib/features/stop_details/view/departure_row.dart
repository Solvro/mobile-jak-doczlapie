import "package:flutter/material.dart";

import "../hooks/use_sorted_departures.dart";
import "../utils.dart";

class DepartureRow extends StatelessWidget {
  const DepartureRow({required this.departure});

  final DepartureWithDirection departure;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => {},
      leading: const Icon(Icons.directions_bus, size: 16),
      title: Row(spacing: 8, children: [Text(formatTime(departure.departure.timestamp)), Text(departure.direction)]),
    );
  }
}
