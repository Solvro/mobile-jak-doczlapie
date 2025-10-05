import "package:flutter/material.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../routes_map/data/route_response.dart";
import "route_list_tile.dart";

class RoutesListWidget extends StatelessWidget {
  const RoutesListWidget({super.key, required this.routes});

  final List<RouteResponse> routes;

  @override
  Widget build(BuildContext context) {
    final children = routes
        .map((route) => RouteListTile(isPunctual: route.routes.first.delay == null, route: route))
        .toList();

    return ListView.separated(
      padding: const EdgeInsets.only(top: p32, bottom: p8),
      itemCount: children.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wyniki",
                style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: p8),
              children[index],
            ],
          );
        }
        return children[index];
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: p8),
    );
  }
}
