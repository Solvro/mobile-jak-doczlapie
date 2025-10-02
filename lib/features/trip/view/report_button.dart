import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

class ReportButton extends StatelessWidget {
  const ReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "report_button",
      onPressed: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Report smth on a trip"),
          actionsAlignment: MainAxisAlignment.center,
          actions: [TextButton(onPressed: () => context.router.maybePop(), child: const Text("Ok"))],
        ),
      ),
      child: const Center(child: Icon(Icons.warning_amber_rounded)),
    );
  }
}
