import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../stops_map/data/latlng_converter.dart";

part "report_dto.freezed.dart";
part "report_dto.g.dart";

@JsonEnum(fieldRename: FieldRename.snake)
enum IncidentType { delay, accident, press, failure, didNotArrive, change, other, differentStopLocation, requestStop }

@freezed
abstract class ReportDto with _$ReportDto {
  const factory ReportDto({
    required IncidentType type,
    required int run,
    @Default("") String description,
    @LatLngConverter() required LatLng coordinates,
  }) = _ReportDto;

  factory ReportDto.fromJson(Map<String, dynamic> json) => _$ReportDtoFromJson(json);
}
