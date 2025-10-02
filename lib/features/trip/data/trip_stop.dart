import "package:freezed_annotation/freezed_annotation.dart";

part "trip_stop.freezed.dart";

@freezed
abstract class TripStop with _$TripStop {
  factory TripStop({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
    required DateTime arrivalTime,
    required DateTime departureTime,
  }) = _TripStop;
}
