import "package:riverpod_annotation/riverpod_annotation.dart";

import "line.dart";
import "stop.dart";

part "stops_repository.g.dart";

@riverpod
Future<List<Stop>> stopsRepository(Ref ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));
  return [
    Stop(
      id: 1,
      name: "Dworzec Główny",
      lines: [
        Line(id: 1, number: "1", direction1: "Dworzec Główny", direction2: "Rynek"),
        Line(id: 2, number: "2", direction1: "Dworzec Główny", direction2: "Rynek"),
        Line(id: 3, number: "3", direction1: "Dworzec Główny", direction2: "Rynek"),
      ],
    ),
    Stop(
      id: 2,
      name: "Rynek",
      lines: [
        Line(id: 2, number: "2", direction1: "Rynek", direction2: "Dworzec Główny"),
        Line(id: 3, number: "3", direction1: "Rynek", direction2: "Dworzec Główny"),
      ],
    ),
    Stop(
      id: 3,
      name: "Uniwersytet",
      lines: [
        Line(id: 3, number: "3", direction1: "Uniwersytet", direction2: "Stadion"),
        Line(id: 4, number: "4", direction1: "Uniwersytet", direction2: "Stadion"),
      ],
    ),
    Stop(
      id: 4,
      name: "Stadion",
      lines: [Line(id: 4, number: "4", direction1: "Stadion", direction2: "Lotnisko")],
    ),
    Stop(
      id: 5,
      name: "Lotnisko",
      lines: [Line(id: 5, number: "5", direction1: "Lotnisko", direction2: "Centrum")],
    ),
    Stop(
      id: 6,
      name: "Centrum",
      lines: [Line(id: 6, number: "6", direction1: "Centrum", direction2: "Lotnisko")],
    ),
    Stop(
      id: 7,
      name: "Park",
      lines: [
        Line(id: 7, number: "7", direction1: "Park", direction2: "Szpital"),
        Line(id: 8, number: "8", direction1: "Park", direction2: "Szpital"),
        Line(id: 9, number: "9", direction1: "Park", direction2: "Szpital"),
      ],
    ),
    Stop(
      id: 8,
      name: "Szpital",
      lines: [
        Line(id: 8, number: "8", direction1: "Szpital", direction2: "Park"),
        Line(id: 9, number: "9", direction1: "Szpital", direction2: "Park"),
      ],
    ),
    Stop(
      id: 9,
      name: "Biblioteka",
      lines: [Line(id: 9, number: "9", direction1: "Biblioteka", direction2: "Szpital")],
    ),
    Stop(
      id: 10,
      name: "Muzeum",
      lines: [Line(id: 10, number: "10", direction1: "Muzeum", direction2: "Biblioteka")],
    ),
  ];
}
