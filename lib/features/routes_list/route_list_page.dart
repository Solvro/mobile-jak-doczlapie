import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "view/route_list_view.dart";

@RoutePage()
class RouteListPage extends StatelessWidget {
  const RouteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RouteListView();
  }
}
