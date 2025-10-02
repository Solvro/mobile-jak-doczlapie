import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../stops/data/direction.dart";
import "../../stops/data/line.dart";
import "../../stops/view/line_chip.dart";
import "../hooks/use_sorted_departures.dart";
import "../utils.dart";
import "departure_row.dart";

class LineExpandingTile extends HookWidget {
  const LineExpandingTile({super.key, required this.line});

  final Line line;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final departures = useSortedDepartures(line);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: LineChip(line: line),
            title: Column(
              children: [
                _DirectionRow(direction: line.direction1),
                _DirectionRow(direction: line.direction2),
              ],
            ),
            trailing: Icon(isExpanded.value ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
          ),
          if (isExpanded.value) ...departures.map((departure) => DepartureRow(departure: departure)),
        ],
      ),
    );
  }
}

class _DirectionRow extends StatelessWidget {
  const _DirectionRow({required this.direction});

  final Direction direction;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        if (direction.departures.isNotEmpty)
          Text(formatTime(direction.departures.first.timestamp))
        else
          const Text("No departures"),
        Text(direction.name, maxLines: 1),
      ],
    );
  }
}
