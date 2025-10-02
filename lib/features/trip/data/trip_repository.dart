import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../stop_details/hooks/use_sorted_departures.dart";
import "trip.dart";
import "trip_stop.dart";

part "trip_repository.g.dart";

// ! vibe code mock gen

@riverpod
Future<Trip> tripRepository(Ref ref, String lineNumber, DepartureWithDirection startingDeparture) async {
  await Future<void>.delayed(const Duration(milliseconds: 300));

  // Mock trip data based on the starting departure
  final direction = startingDeparture.direction;
  final startTime = startingDeparture.departure.timestamp;

  // Generate mock stops along the route
  final stops = _generateMockStops(startTime, direction);

  return Trip(
    id: 1,
    lineNumber: lineNumber,
    direction: direction,
    stops: stops,
    startTime: startTime,
    endTime: stops.last.departureTime,
  );
}

List<TripStop> _generateMockStops(DateTime startTime, String direction) {
  // Mock stop data with realistic coordinates for a Polish city
  final mockStopsData = [
    {"name": "Dworzec Główny", "lat": 50.2649, "lng": 19.0238, "duration": 0},
    {"name": "Rynek", "lat": 50.2640, "lng": 19.0250, "duration": 3},
    {"name": "Uniwersytet", "lat": 50.2630, "lng": 19.0260, "duration": 6},
    {"name": "Stadion", "lat": 50.2620, "lng": 19.0270, "duration": 9},
    {"name": "Lotnisko", "lat": 50.2610, "lng": 19.0280, "duration": 12},
    {"name": "Centrum", "lat": 50.2600, "lng": 19.0290, "duration": 15},
    {"name": "Park", "lat": 50.2590, "lng": 19.0300, "duration": 18},
  ];

  // Filter stops based on direction
  List<Map<String, dynamic>> selectedStops;
  if (direction.contains("Dworzec")) {
    selectedStops = mockStopsData.take(4).toList();
  } else if (direction.contains("Uniwersytet")) {
    selectedStops = mockStopsData.skip(1).take(4).toList();
  } else if (direction.contains("Stadion")) {
    selectedStops = mockStopsData.skip(2).take(4).toList();
  } else if (direction.contains("Lotnisko")) {
    selectedStops = mockStopsData.skip(3).take(4).toList();
  } else {
    selectedStops = mockStopsData.take(4).toList();
  }

  return selectedStops.asMap().entries.map((entry) {
    final index = entry.key;
    final stop = entry.value;
    final arrivalTime = startTime.add(Duration(minutes: stop["duration"] as int));
    final departureTime = arrivalTime.add(const Duration(minutes: 1)); // 1 minute stop time

    return TripStop(
      id: index + 1,
      name: stop["name"] as String,
      latitude: stop["lat"] as double,
      longitude: stop["lng"] as double,
      arrivalTime: arrivalTime,
      departureTime: departureTime,
    );
  }).toList();
}
