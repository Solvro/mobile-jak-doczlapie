import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/tokens.dart";
import "../../stops/data/line.dart";
import "../../stops/data/schedule.dart";
import "../../stops/view/line_chip.dart";
import "../hooks/use_first_departure_time.dart";
import "departure_row.dart";

class LineExpandingTile extends HookWidget {
  const LineExpandingTile({super.key, required this.line});

  final Line line;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: p8, vertical: p4),
      child: Column(
        children: [
          ListTile(
            leading: LineChip(lineNumber: line.name),
            title: Column(
              children: [
                ...line.destinations?.map(
                      (destination) => _HeaderDirectionRow(schedules: line.schedules ?? [], direction: destination),
                    ) ??
                    [],
              ],
            ),
            trailing: Icon(isExpanded.value ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
          ),
          if (isExpanded.value)
            ...line.schedules?.map(
                  (schedule) => DepartureRow(schedule: schedule, lineNumber: line.name, lineId: line.id.toString()),
                ) ??
                [],
        ],
      ),
    );
  }
}

class _HeaderDirectionRow extends HookWidget {
  const _HeaderDirectionRow({required this.schedules, required this.direction});

  final List<Schedule> schedules;
  final String direction;

  @override
  Widget build(BuildContext context) {
    final firstDepartureTime = useFirstDepartureTime(schedules, direction);
    return Row(spacing: p8, children: [Text(firstDepartureTime), Text(direction, maxLines: 1)]);
  }
}
