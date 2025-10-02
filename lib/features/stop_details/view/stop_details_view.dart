import "package:flutter/material.dart";
import "../../../common/widgets/app_bar.dart";
import "../../stops/data/stop.dart";
import "line_expanding_tile.dart";

class StopDetailsView extends StatelessWidget {
  const StopDetailsView({super.key, required this.stop});

  final Stop stop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: stop.name),
      body: ListView.builder(
        itemCount: stop.lines.length,
        itemBuilder: (context, index) => LineExpandingTile(line: stop.lines[index]),
      ),
    );
  }
}
