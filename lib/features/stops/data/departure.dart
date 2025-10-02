import "package:freezed_annotation/freezed_annotation.dart";

part "departure.freezed.dart";

@freezed
abstract class Departure with _$Departure {
  factory Departure({required DateTime timestamp}) = _Departure;
}
