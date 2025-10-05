import "package:auto_route/auto_route.dart" show RoutePage;
import "package:flutter/material.dart";

import "../../common/widgets/gradient_scaffold.dart";
import "../../common/widgets/pop_button.dart";
import "../routes_map/data/route_response.dart";
import "../routes_map/view/vert_route_card.dart";

@RoutePage()
class RouteTripPage extends StatelessWidget {
  const RouteTripPage({super.key, required this.route});
  final RouteResponse route;
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Column(
          children: [
            const PopButton(),
            const Text("to jest mock detail view"),
            VertRouteCard(route: route),
          ],
        ),
      ),
    );
  }
}
