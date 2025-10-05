import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../bottom_nav/domain/bottom_nav_controller.dart";
import "../bottom_nav/view/map_list_switch.dart";
import "../routes_list/view/route_list_view.dart";
import "../stops_map/hooks/use_coords.dart";
import "data/routes_repository.dart";
import "view/route_detail_view.dart";

@RoutePage()
class RouteDetailsPage extends HookConsumerWidget {
  const RouteDetailsPage({super.key, required this.fromAddress, required this.toAddress});

  final String fromAddress;
  final String toAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordsFrom = useCoords(fromAddress);
    final coordsTo = useCoords(toAddress);

    final routesAsync = ref.watch(
      routesRepositoryProvider(
        coordsFrom.data?.latitude != null && coordsTo.data?.latitude != null
            ? (
                fromLongitude: coordsFrom.data!.longitude,
                fromLatitude: coordsFrom.data!.latitude,
                toLongitude: coordsTo.data!.longitude,
                toLatitude: coordsTo.data!.latitude,
              )
            : null,
      ),
    );

    final activeViewType = ref.watch(viewTypeControllerProvider);
    return switch (activeViewType) {
      ViewType.map => RouteDetailsView(routes: routesAsync.value),
      ViewType.list => RouteListView(routes: routesAsync.value),
    };
  }
}
