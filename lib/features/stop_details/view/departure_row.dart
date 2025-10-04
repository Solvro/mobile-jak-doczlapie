import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/tokens.dart";

import "../../stops/data/schedule.dart";

class DepartureRow extends StatelessWidget {
  const DepartureRow({required this.schedule, required this.lineNumber, required this.lineId});
  final String lineNumber;
  final String lineId;
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.router.push(TripRoute(lineId: lineId, runId: schedule.run, direction: schedule.destination)),
      leading: const Icon(Icons.directions_bus, size: p16),
      title: Row(spacing: p8, children: [Text(schedule.time), Text(schedule.destination)]),
    );
  }
}
