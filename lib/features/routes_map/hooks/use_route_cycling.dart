import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/tokens.dart";
import "../data/route_response.dart";

/// Hook for managing route cycling functionality
///
/// Returns a function that cycles through available routes,
/// moving to the next route when reaching the end.
/// Also scrolls to the active route in the list.
VoidCallback useRouteCycling({
  required ValueNotifier<RouteResponse?> activeRoute,
  required List<RouteResponse>? routes,
  required ScrollController scrollController,
}) {
  return useCallback(() async {
    final currentActive = activeRoute.value;
    final routesList = routes ?? [];

    if (routesList.isEmpty) return;

    // If no active route, set first route
    if (currentActive == null) {
      activeRoute.value = routesList.first;
      await useScrollToRoute(scrollController: scrollController, routeIndex: 0);
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
      await useScrollToRoute(scrollController: scrollController, routeIndex: nextRouteIndex);
    }
  }, [activeRoute, routes, scrollController]);
}

/// Common hook for scrolling to a specific route index
///
/// Returns a function that scrolls to the specified route index in the list.
/// This is shared logic used by both route cycling and specific route navigation.
Future<void> useScrollToRoute({required ScrollController scrollController, required int routeIndex}) async {
  if (scrollController.hasClients) {
    await scrollController.animateTo(
      routeIndex * (167 + p8), // Calculate position based on card width (167) and spacing (p8)
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
