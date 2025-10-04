import "package:freezed_annotation/freezed_annotation.dart";

import "schedule.dart";
import "stop.dart";

part "line.freezed.dart";
part "line.g.dart";

@freezed
abstract class Line with _$Line {
  factory Line({
    required int id,
    required String name,
    required String operator,
    List<String>? destinations,
    List<Stop>? stops,
    List<Schedule>? schedules,
  }) = _Line;

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
}
