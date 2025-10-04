import "package:flutter/foundation.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../view/route_detail_view.dart";

/// Hook for managing route cycling functionality
///
/// Returns a function that cycles through available routes,
/// moving to the next route when reaching the end.
VoidCallback useRouteCycling({required ValueNotifier<Route?> activeRoute, required List<Route>? routes}) {
  return useCallback(() {
    final currentActive = activeRoute.value;
    final routesList = routes ?? [];

    if (routesList.isEmpty) return;

    // If no active route, set first route
    if (currentActive == null) {
      activeRoute.value = routesList.first;
      return;
    }

    // Find current route index
    var currentRouteIndex = -1;

    for (var i = 0; i < routesList.length; i++) {
      if (routesList[i] == currentActive) {
        currentRouteIndex = i;
        break;
      }
    }

    // Move to next route
    if (currentRouteIndex != -1) {
      // Move to next route (wrap around to first if at end)
      final nextRouteIndex = (currentRouteIndex + 1) % routesList.length;
      activeRoute.value = routesList[nextRouteIndex];
    }
  }, [activeRoute, routes]);
}
