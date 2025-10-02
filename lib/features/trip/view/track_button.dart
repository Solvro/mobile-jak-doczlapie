import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

class TrackButton extends StatelessWidget {
  const TrackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "track_button",
      onPressed: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Track a trip"),
          actionsAlignment: MainAxisAlignment.center,
          actions: [TextButton(onPressed: () => context.router.maybePop(), child: const Text("Ok"))],
        ),
      ),
      child: const Center(child: Icon(Icons.track_changes_outlined)),
    );
  }
}
