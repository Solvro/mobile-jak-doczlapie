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
    mapController.move(nextStop.coordinates, 16);

    // Scroll to the next stop in the list
    await useScrollToStop(scrollController: scrollController, stopIndex: nextIndex);
  }, [stops, activeStop, mapController, scrollController]);
}

/// Common hook for scrolling to a specific stop index
///
/// Returns a function that scrolls to the specified stop index in the list.
/// This is shared logic used by both next stop navigation and specific stop navigation.
Future<void> useScrollToStop({required ScrollController scrollController, required int stopIndex}) async {
  if (scrollController.hasClients) {
    await scrollController.animateTo(
      stopIndex * (167 + p8), // Calculate position based on card width (167) and spacing (p8)
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

/// Hook for navigating to a specific stop
///
/// Returns a function that navigates to the specified stop,
/// updating the active stop, moving the map, and scrolling to it.
Future<void> Function(Stop) useSpecificStopNavigation({
  required List<Stop> stops,
  required ValueNotifier<Stop?> activeStop,
  required MapController mapController,
  required ScrollController scrollController,
}) {
  return useCallback((Stop targetStop) async {
    // Find the target stop index
    final targetIndex = stops.indexWhere((stop) => stop.id == targetStop.id);

    if (targetIndex == -1) return; // Stop not found

    // Set target stop as active
    activeStop.value = targetStop;

    // Move map to target stop
    mapController.move(targetStop.coordinates, 16);

    // Scroll to the target stop in the list
    await useScrollToStop(scrollController: scrollController, stopIndex: targetIndex);
  }, [stops, activeStop, mapController, scrollController]);
}
