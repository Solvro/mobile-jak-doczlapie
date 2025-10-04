import "package:freezed_annotation/freezed_annotation.dart";

import "condition.dart";

part "schedule.freezed.dart";
part "schedule.g.dart";

@freezed
abstract class Schedule with _$Schedule {
  const factory Schedule({
    required int id,
    required String time,
    required String destination,
    required int run,
    required int sequence,
    List<Condition>? conditions,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
}
