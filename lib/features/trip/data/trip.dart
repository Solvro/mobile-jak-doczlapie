import "package:freezed_annotation/freezed_annotation.dart";

import "trip_stop.dart";

part "trip.freezed.dart";

@freezed
abstract class Trip with _$Trip {
  factory Trip({
    required int id,
    required String lineNumber,
    required String direction,
    required List<TripStop> stops,
    required DateTime startTime,
    required DateTime endTime,
  }) = _Trip;
}
