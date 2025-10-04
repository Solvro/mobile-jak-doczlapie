import "package:dio/dio.dart";
import "package:retrofit/error_logger.dart";
import "package:retrofit/http.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "line.dart";
import "stop.dart";

part "rest_client.g.dart";

@RestApi(baseUrl: "https://jak-doczlapie-hackyeah.b.solvro.pl/")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET("api/v1/routes/{id}")
  Future<Line> getLine(@Path("id") String id);

  @GET("/api/v1/stops")
  Future<List<Stop>> getNearbyStops(
    @Query("latitude") String latitude,
    @Query("longitude") String longitiude,
    @Query("radium") String? radium,
  );

  @GET("/api/v1/stops/{id}")
  Future<Stop> getStopDetails(@Path("id") String id);
}

@riverpod
RestClient restClient(Ref ref) {
  return RestClient(Dio());
}
