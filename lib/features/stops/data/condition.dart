import "package:freezed_annotation/freezed_annotation.dart";

part "condition.g.dart";
part "condition.freezed.dart";

@freezed
abstract class Condition with _$Condition {
  const factory Condition({required int id, required String name, required String description}) = _Condition;

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
}
