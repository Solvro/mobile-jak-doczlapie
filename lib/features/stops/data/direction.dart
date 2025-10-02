import "package:freezed_annotation/freezed_annotation.dart";

import "departure.dart";

part "direction.freezed.dart";

@freezed
abstract class Direction with _$Direction {
  factory Direction({required int id, required String name, required List<Departure> departures}) = _Direction;
}
