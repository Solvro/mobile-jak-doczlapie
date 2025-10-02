import "package:freezed_annotation/freezed_annotation.dart";

part "line.freezed.dart";

@freezed
abstract class Line with _$Line {
  factory Line({required int id, required String number, required String direction1, required String direction2}) =
      _Line;
}
