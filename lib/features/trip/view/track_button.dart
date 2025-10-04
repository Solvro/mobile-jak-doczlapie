import "package:flutter/material.dart";

class TrackButton extends StatelessWidget {
  const TrackButton({super.key, required this.isEnabled, required this.onToggle});

  final bool isEnabled;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "track_button",
      backgroundColor: isEnabled ? Colors.red : null,
      onPressed: onToggle,
      child: Center(
        child: Icon(isEnabled ? Icons.stop : Icons.track_changes_outlined, color: isEnabled ? Colors.white : null),
      ),
    );
  }
}
