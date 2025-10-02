import "package:freezed_annotation/freezed_annotation.dart";

import "direction.dart";

part "line.freezed.dart";

@freezed
abstract class Line with _$Line {
  factory Line({
    required int id,
    required String number,
    required Direction direction1,
    required Direction direction2,
  }) = _Line;
}
