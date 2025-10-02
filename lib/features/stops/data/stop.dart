import "package:freezed_annotation/freezed_annotation.dart";

import "line.dart";

part "stop.freezed.dart";

@freezed
abstract class Stop with _$Stop {
  factory Stop({required int id, required String name, required List<Line> lines}) = _Stop;
}
