import "package:riverpod_annotation/riverpod_annotation.dart";

import "stop.dart";

part "stops_repository.g.dart";

@riverpod
Future<List<Stop>> stopsRepository(Ref ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));
  return [
    Stop(id: 1, name: "Dworzec Główny"),
    Stop(id: 2, name: "Rynek"),
    Stop(id: 3, name: "Uniwersytet"),
    Stop(id: 4, name: "Stadion"),
    Stop(id: 5, name: "Lotnisko"),
    Stop(id: 6, name: "Centrum"),
    Stop(id: 7, name: "Park"),
    Stop(id: 8, name: "Szpital"),
    Stop(id: 9, name: "Biblioteka"),
    Stop(id: 10, name: "Muzeum"),
  ];
}
