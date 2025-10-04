import "package:flutter/material.dart";
import "../../../app/tokens.dart";
import "route_list_app_bar.dart";
import "route_list_tile.dart";

class RouteListView extends StatelessWidget {
  const RouteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: const RouteListAppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(p16),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => RouteListTile(isPunctual: index.isOdd),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: p8),
      ),
    );
  }
}
