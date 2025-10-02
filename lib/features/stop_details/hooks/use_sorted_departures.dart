import "package:flutter_hooks/flutter_hooks.dart";

import "../../stops/data/departure.dart";
import "../../stops/data/line.dart";

typedef DepartureWithDirection = ({Departure departure, String direction});

List<DepartureWithDirection> useSortedDepartures(Line line) {
  return useMemoized(() {
    final combined = [
      ...line.direction1.departures.map((departure) => (departure: departure, direction: line.direction1.name)),
      ...line.direction2.departures.map((departure) => (departure: departure, direction: line.direction2.name)),
    ];
    combined.sort((a, b) => a.departure.timestamp.compareTo(b.departure.timestamp));
    return combined;
  }, [line.direction1.departures, line.direction2.departures]);
}
