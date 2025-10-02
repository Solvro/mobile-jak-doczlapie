import "package:flutter/material.dart";
import "../../../common/widgets/app_bar.dart";
import "../data/stop.dart";
import "stop_tile.dart";

class StopsView extends StatelessWidget {
  const StopsView({super.key, required this.stops});

  final List<Stop> stops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Przystanki"),
      body: ListView.builder(
        itemCount: stops.length,
        itemBuilder: (context, index) => StopTile(stop: stops[index]),
      ),
    );
  }
}
