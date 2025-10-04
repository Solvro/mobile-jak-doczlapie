import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../bottom_nav/domain/bottom_nav_controller.dart";
import "../bottom_nav/view/map_list_switch.dart";
import "../routes_list/view/route_list_view.dart";
import "view/route_detail_view.dart";

@RoutePage()
class RouteDetailsPage extends ConsumerWidget {
  const RouteDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeViewType = ref.watch(viewTypeControllerProvider);
    return switch (activeViewType) {
      ViewType.map => const RouteDetailsView(),
      ViewType.list => const RouteListView(),
    };
  }
}
