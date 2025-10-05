import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../bottom_nav/domain/bottom_nav_controller.dart";
import "../bottom_nav/view/map_list_switch.dart";
import "../routes_list/view/route_list_view.dart";
import "../stops_map/hooks/use_coords.dart";
import "data/routes_repository.dart";
import "view/routes_map_view.dart";

@RoutePage()
class RoutesMapPage extends HookConsumerWidget {
  const RoutesMapPage({super.key, required this.fromAddress, required this.toAddress});

  final String fromAddress;
  final String toAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromAddressState = useState(fromAddress);
    final toAddressState = useState(toAddress);
    final coordsFrom = useCoords(fromAddressState.value);
    final coordsTo = useCoords(toAddressState.value);

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
      ViewType.map => RoutesMapView(
        routes: routesAsync.value,
        fromAddress: fromAddressState,
        toAddress: toAddressState,
      ),
      ViewType.list => RouteListView(
        routes: routesAsync.value,
        fromAddress: fromAddressState,
        toAddress: toAddressState,
      ),
    };
  }
}
