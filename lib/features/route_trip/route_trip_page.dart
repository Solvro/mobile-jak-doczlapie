import "package:auto_route/auto_route.dart" show RoutePage;
import "package:flutter/material.dart";

import "../routes_map/data/route_response.dart";
import "../trip/view/trip_view.dart";

@RoutePage()
class RouteTripPage extends StatelessWidget {
  const RouteTripPage({super.key, required this.route});
  final RouteResponse route;
  @override
  Widget build(BuildContext context) {
    return TripView(route: route);
  }
}
