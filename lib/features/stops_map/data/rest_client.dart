import "package:dio/dio.dart" hide Headers;
import "package:flutter/widgets.dart";
import "package:retrofit/error_logger.dart";
import "package:retrofit/http.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../routes_map/data/route_response.dart";
import "../../trip/data/track_response.dart";
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
    @Query("radius") String? radius,
  );

  @GET("/api/v1/stops/{id}")
  Future<Stop> getStopDetails(@Path("id") String id);

  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  @POST("/api/v1/routes/{id}/tracks")
  Future<void> sendUserTrack(@Path("id") String id, @Body() TrackResponse trackResponse);

  @GET("/api/v1/routes")
  Future<List<RouteResponse>> getRoutes(
    @Query("fromLongitude") String fromLongitude,
    @Query("fromLatitude") String fromLatitude,
    @Query("toLongitude") String toLongitude,
    @Query("toLatitude") String toLatitude,
    @Query("radius") String? radius,
  );
}

@riverpod
RestClient restClient(Ref ref) {
  final dio = Dio();

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true, logPrint: (object) => debugPrint("🌐 HTTP: $object")),
  );

  return RestClient(dio);
}
