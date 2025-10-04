import "package:flutter/foundation.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../stops_map/data/line.dart";

typedef LineWithDestination = ({Line line, String destination});

/// Hook for managing line cycling functionality
///
/// Returns a function that cycles through available lines and destinations
/// for a given stop, moving to the next destination in the current line
/// or to the first destination of the next line when reaching the end.
VoidCallback useLineCycling({required ValueNotifier<LineWithDestination?> activeLine, required List<Line>? routes}) {
  return useCallback(() {
    final currentActive = activeLine.value;
    final routesList = routes ?? [];

    if (routesList.isEmpty) return;

    // If no active line, set first line with first destination
    if (currentActive == null) {
      final firstLine = routesList.first;
      final firstDestination = firstLine.destinations?.first;
      if (firstDestination != null) {
        activeLine.value = (line: firstLine, destination: firstDestination);
      }
      return;
    }

    // Find current line index and destination index
    var currentLineIndex = -1;
    var currentDestinationIndex = -1;

    for (var i = 0; i < routesList.length; i++) {
      if (routesList[i].id == currentActive.line.id) {
        currentLineIndex = i;
        final destinations = routesList[i].destinations ?? [];
        for (var j = 0; j < destinations.length; j++) {
          if (destinations[j] == currentActive.destination) {
            currentDestinationIndex = j;
            break;
          }
        }
        break;
      }
    }

    // Move to next destination or next line
    if (currentLineIndex != -1) {
      final currentLine = routesList[currentLineIndex];
      final destinations = currentLine.destinations ?? [];

      // Try next destination in current line
      if (currentDestinationIndex < destinations.length - 1) {
        activeLine.value = (line: currentLine, destination: destinations[currentDestinationIndex + 1]);
      } else {
        // Move to next line's first destination
        final nextLineIndex = (currentLineIndex + 1) % routesList.length;
        final nextLine = routesList[nextLineIndex];
        final nextDestination = nextLine.destinations?.first;
        if (nextDestination != null) {
          activeLine.value = (line: nextLine, destination: nextDestination);
        }
      }
    }
  }, [activeLine, routes]);
}
