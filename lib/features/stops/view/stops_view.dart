import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "../../../app/router.dart";
import "../../../common/widgets/app_bar.dart";
import "../data/stop.dart";
import "stop_tile.dart";

class StopsView extends StatelessWidget {
  const StopsView({super.key, required this.stops});

  final List<Stop> stops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Przystanki",
        actions: [
          IconButton(
            onPressed: () => context.router.push(const ReportScheduleRoute()),
            icon: const Icon(Icons.feedback),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: stops.length,
        itemBuilder: (context, index) => StopTile(stop: stops[index]),
      ),
    );
  }
}
