// ignore_for_file: avoid_dynamic_calls, inference_failure_on_function_invocation

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";

class MapboxGeocoding {
  static const _accessToken =
      "pk.eyJ1IjoibWFwYm94dG9tdHJlIiwiYSI6ImNtZ2RmNGJ6dzFlYXMybHNoMWJqbGFmNjMifQ.yIcdFJMdty-vvqRWTOLwPg"; // Zamień na swój token
  static const _baseUrl = "https://api.mapbox.com/search/geocode/v6";

  final Dio _dio;

  MapboxGeocoding({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: _baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<String?> getAddressFromCoords(LatLng coords) async {
    try {
      final response = await _dio.get(
        "/reverse",
        queryParameters: {"longitude": coords.longitude, "latitude": coords.latitude, "access_token": _accessToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data["features"] != null && (data["features"] as List).isNotEmpty) {
          final feature = data["features"][0];
          final properties = feature["properties"];
          final context = properties["context"];

          String? street;
          String? houseNumber;
          String? city;

          // Wyciągnij ulicę i numer domu z context.address
          if (context != null && context["address"] != null) {
            final addressContext = context["address"];
            street = addressContext["street_name"] as String?;
            houseNumber = addressContext["address_number"] as String?;
          }

          // Wyciągnij miasto z context.place
          if (context != null && context["place"] != null) {
            city = context["place"]["name"] as String?;
          }

          // Zbuduj adres
          final streetPart = street != null && houseNumber != null ? "$street $houseNumber" : street ?? "";

          if (streetPart.isNotEmpty && city != null) {
            return "$streetPart, $city";
          } else if (streetPart.isNotEmpty) {
            return streetPart;
          } else if (city != null) {
            return city;
          }

          // Fallback do pełnego adresu
          return properties["full_address"] as String?;
        }
      }
    } on DioException catch (e) {
      debugPrint("Dio error in reverse geocoding: ${e.message}");
      return null;
    } on Exception catch (e) {
      debugPrint("Error in reverse geocoding: $e");
      return null;
    }

    return null;
  }

  Future<LatLng?> getCoordsFromAddress(String address) async {
    try {
      final response = await _dio.get(
        "/forward",
        queryParameters: {"q": address, "limit": 1, "access_token": _accessToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data["features"] != null && (data["features"] as List).isNotEmpty) {
          final feature = data["features"][0];
          final geometry = feature["geometry"];

          if (geometry != null && geometry["coordinates"] != null) {
            final coordinates = geometry["coordinates"] as List;
            final lon = coordinates[0] as num;
            final lat = coordinates[1] as num;

            return LatLng(lat.toDouble(), lon.toDouble());
          }
        }
      }

      return null;
    } on DioException catch (e) {
      debugPrint("Dio error in forward geocoding: ${e.message}");
      return null;
    } on Exception catch (e) {
      debugPrint("Error in forward geocoding: $e");
      return null;
    }
  }
}
