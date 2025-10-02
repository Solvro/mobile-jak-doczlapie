import "package:riverpod_annotation/riverpod_annotation.dart";

import "departure.dart";
import "direction.dart";
import "line.dart";
import "stop.dart";

part "stops_repository.g.dart";

@riverpod
Future<List<Stop>> stopsRepository(Ref ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));

  // Helper function to generate realistic departure times
  List<Departure> generateDepartures(int baseMinutes) {
    final now = DateTime.now();
    return List.generate(5, (index) {
      final minutes = baseMinutes + (index * 8); // Every 8 minutes
      return Departure(timestamp: now.add(Duration(minutes: minutes)));
    });
  }

  return [
    Stop(
      id: 1,
      name: "Dworzec Główny",
      lines: [
        Line(
          id: 1,
          number: "1",
          direction1: Direction(id: 1, name: "Dworzec Główny", departures: generateDepartures(2)),
          direction2: Direction(id: 2, name: "Rynek", departures: generateDepartures(5)),
        ),
        Line(
          id: 2,
          number: "2",
          direction1: Direction(id: 3, name: "Dworzec Główny", departures: generateDepartures(3)),
          direction2: Direction(id: 4, name: "Uniwersytet", departures: generateDepartures(7)),
        ),
        Line(
          id: 3,
          number: "3",
          direction1: Direction(id: 5, name: "Dworzec Główny", departures: generateDepartures(1)),
          direction2: Direction(id: 6, name: "Stadion", departures: generateDepartures(4)),
        ),
      ],
    ),
    Stop(
      id: 2,
      name: "Rynek",
      lines: [
        Line(
          id: 1,
          number: "1",
          direction1: Direction(id: 1, name: "Dworzec Główny", departures: generateDepartures(6)),
          direction2: Direction(id: 2, name: "Rynek", departures: generateDepartures(3)),
        ),
        Line(
          id: 2,
          number: "2",
          direction1: Direction(id: 3, name: "Dworzec Główny", departures: generateDepartures(8)),
          direction2: Direction(id: 4, name: "Uniwersytet", departures: generateDepartures(2)),
        ),
      ],
    ),
    Stop(
      id: 3,
      name: "Uniwersytet",
      lines: [
        Line(
          id: 2,
          number: "2",
          direction1: Direction(id: 3, name: "Dworzec Główny", departures: generateDepartures(9)),
          direction2: Direction(id: 4, name: "Uniwersytet", departures: generateDepartures(1)),
        ),
        Line(
          id: 3,
          number: "3",
          direction1: Direction(id: 5, name: "Dworzec Główny", departures: generateDepartures(5)),
          direction2: Direction(id: 6, name: "Stadion", departures: generateDepartures(3)),
        ),
        Line(
          id: 4,
          number: "4",
          direction1: Direction(id: 7, name: "Uniwersytet", departures: generateDepartures(2)),
          direction2: Direction(id: 8, name: "Lotnisko", departures: generateDepartures(6)),
        ),
      ],
    ),
    Stop(
      id: 4,
      name: "Stadion",
      lines: [
        Line(
          id: 3,
          number: "3",
          direction1: Direction(id: 5, name: "Dworzec Główny", departures: generateDepartures(7)),
          direction2: Direction(id: 6, name: "Stadion", departures: generateDepartures(4)),
        ),
        Line(
          id: 4,
          number: "4",
          direction1: Direction(id: 7, name: "Uniwersytet", departures: generateDepartures(3)),
          direction2: Direction(id: 8, name: "Lotnisko", departures: generateDepartures(8)),
        ),
      ],
    ),
    Stop(
      id: 5,
      name: "Lotnisko",
      lines: [
        Line(
          id: 4,
          number: "4",
          direction1: Direction(id: 7, name: "Uniwersytet", departures: generateDepartures(9)),
          direction2: Direction(id: 8, name: "Lotnisko", departures: generateDepartures(2)),
        ),
        Line(
          id: 5,
          number: "5",
          direction1: Direction(id: 9, name: "Lotnisko", departures: generateDepartures(1)),
          direction2: Direction(id: 10, name: "Centrum", departures: generateDepartures(5)),
        ),
      ],
    ),
    Stop(
      id: 6,
      name: "Centrum",
      lines: [
        Line(
          id: 5,
          number: "5",
          direction1: Direction(id: 9, name: "Lotnisko", departures: generateDepartures(6)),
          direction2: Direction(id: 10, name: "Centrum", departures: generateDepartures(3)),
        ),
        Line(
          id: 6,
          number: "6",
          direction1: Direction(id: 11, name: "Centrum", departures: generateDepartures(2)),
          direction2: Direction(id: 12, name: "Park", departures: generateDepartures(7)),
        ),
      ],
    ),
    Stop(
      id: 7,
      name: "Park",
      lines: [
        Line(
          id: 6,
          number: "6",
          direction1: Direction(id: 11, name: "Centrum", departures: generateDepartures(8)),
          direction2: Direction(id: 12, name: "Park", departures: generateDepartures(1)),
        ),
        Line(
          id: 7,
          number: "7",
          direction1: Direction(id: 13, name: "Park", departures: generateDepartures(3)),
          direction2: Direction(id: 14, name: "Szpital", departures: generateDepartures(6)),
        ),
        Line(
          id: 8,
          number: "8",
          direction1: Direction(id: 15, name: "Park", departures: generateDepartures(4)),
          direction2: Direction(id: 16, name: "Biblioteka", departures: generateDepartures(9)),
        ),
      ],
    ),
    Stop(
      id: 8,
      name: "Szpital",
      lines: [
        Line(
          id: 7,
          number: "7",
          direction1: Direction(id: 13, name: "Park", departures: generateDepartures(7)),
          direction2: Direction(id: 14, name: "Szpital", departures: generateDepartures(2)),
        ),
        Line(
          id: 8,
          number: "8",
          direction1: Direction(id: 15, name: "Park", departures: generateDepartures(5)),
          direction2: Direction(id: 16, name: "Biblioteka", departures: generateDepartures(8)),
        ),
        Line(
          id: 9,
          number: "9",
          direction1: Direction(id: 17, name: "Szpital", departures: generateDepartures(1)),
          direction2: Direction(id: 18, name: "Muzeum", departures: generateDepartures(4)),
        ),
      ],
    ),
    Stop(
      id: 9,
      name: "Biblioteka",
      lines: [
        Line(
          id: 8,
          number: "8",
          direction1: Direction(id: 15, name: "Park", departures: generateDepartures(6)),
          direction2: Direction(id: 16, name: "Biblioteka", departures: generateDepartures(3)),
        ),
        Line(
          id: 9,
          number: "9",
          direction1: Direction(id: 17, name: "Szpital", departures: generateDepartures(2)),
          direction2: Direction(id: 18, name: "Muzeum", departures: generateDepartures(7)),
        ),
      ],
    ),
    Stop(
      id: 10,
      name: "Muzeum",
      lines: [
        Line(
          id: 9,
          number: "9",
          direction1: Direction(id: 17, name: "Szpital", departures: generateDepartures(8)),
          direction2: Direction(id: 18, name: "Muzeum", departures: generateDepartures(1)),
        ),
        Line(
          id: 10,
          number: "10",
          direction1: Direction(id: 19, name: "Muzeum", departures: generateDepartures(3)),
          direction2: Direction(id: 20, name: "Dworzec Główny", departures: generateDepartures(6)),
        ),
      ],
    ),
  ];
}
