import 'package:flutter/material.dart';
import 'package:jak_doczlapie/app/router.dart';
import 'package:jak_doczlapie/common/widgets/app_bar.dart';
import 'package:jak_doczlapie/features/home/data/stop.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.stops});

  final List<Stop> stops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Linie"),
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
