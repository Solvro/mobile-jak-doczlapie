import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "../../../app/router.dart";
import "../data/stop.dart";
import "line_chip.dart";

class StopTile extends StatelessWidget {
  const StopTile({super.key, required this.stop});

  final Stop stop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stop.name),
      trailing: Wrap(children: stop.lines.map((line) => LineChip(lineNumber: line.number)).toList()),
      onTap: () => context.router.push(StopDetailsRoute(id: stop.id)),
    );
  }
}
