import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../app/tokens.dart";
import "../data/stop.dart";

/// Hook for managing next stop navigation functionality
///
/// Returns a function that navigates to the next stop in the list,
/// wrapping around to the first stop when reaching the end.
///
/// The function handles:
/// - Finding the current active stop index
/// - Calculating the next stop index (with wrap-around)
/// - Updating the active stop
/// - Moving the map to the next stop
/// - Scrolling the list to show the next stop
VoidCallback useNextStopNavigation({
  required List<Stop> stops,
  required ValueNotifier<Stop?> activeStop,
  required MapController mapController,
  required ScrollController scrollController,
}) {
  return useCallback(() async {
    // Find current active stop index
    final currentIndex = activeStop.value != null ? stops.indexWhere((stop) => stop.id == activeStop.value!.id) : -1;

    // Calculate next index (wrap around to 0 if at end)
    final nextIndex = currentIndex < stops.length - 1 ? currentIndex + 1 : 0;

    // Set next stop as active
    final nextStop = stops[nextIndex];
    activeStop.value = nextStop;

    // Move map to next stop
    mapController.moveAndRotate(nextStop.coordinates, 16, 0);

    // Scroll to the next stop in the list
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        nextIndex * (167 + p8), // Calculate position based on card width (167) and spacing (p8)
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }, [stops, activeStop, mapController, scrollController]);
}
