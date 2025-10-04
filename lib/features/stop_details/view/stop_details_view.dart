import "package:flutter/material.dart";
import "../../../common/widgets/app_bar.dart";
import "../../stops_map/data/stop.dart";
import "line_expanding_tile.dart";

class StopDetailsView extends StatelessWidget {
  const StopDetailsView({super.key, required this.stop});

  final Stop stop;

  @override
  Widget build(BuildContext context) {
    final lines = stop.routes;
    if (lines == null) {
      throw Exception("Stop has no routes");
    }
    return Scaffold(
      appBar: const CommonAppBar(),
      body: ListView.builder(
        itemCount: lines.length,
        itemBuilder: (context, index) => LineExpandingTile(line: lines[index]),
      ),
    );
  }
}
