import "package:flutter/material.dart";
import "../../../app/router.dart";
import "../../../common/widgets/app_bar.dart";
import "../data/stop.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.stops});

  final List<Stop> stops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Linie"),
      body: ListView.builder(
        itemCount: stops.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(stops[index].name),
          onTap: () => StopDetailsRoute(id: stops[index].id).push(context),
        ),
      ),
    );
  }
}
