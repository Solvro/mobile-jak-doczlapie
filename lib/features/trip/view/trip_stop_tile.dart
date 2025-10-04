import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../data/trip_repository.dart";

class TripStopTile extends StatelessWidget {
  const TripStopTile({super.key, required this.stop, required this.onStopTap, required this.index});

  final TripStop stop;
  final void Function(int index) onStopTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: context.colorScheme.primary,
        child: Text(
          "${index + 1}",
          style: TextStyle(color: context.colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text("${stop.time} ${stop.name}"),

      onTap: () => onStopTap(index),
    );
  }
}
