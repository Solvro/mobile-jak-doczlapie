import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:latlong2/latlong.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "location_service.g.dart";

class LocationService {
  static Future<void> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }
  }

  static Future<LatLng> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  static Future<String?> getPlacemark() async {
    try {
      final position = await Geolocator.getCurrentPosition();

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 3));

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];

        final parts = <String>[];

        if (place.street?.isNotEmpty ?? false) parts.add(place.street!);
        if (place.locality?.isNotEmpty ?? false) parts.add(place.locality!);
        if (place.administrativeArea?.isNotEmpty ?? false) parts.add(place.administrativeArea!);

        final result = parts.isNotEmpty ? parts.join(", ") : null;
        return result;
      }

      return null;
    } on Exception {
      final position = await Geolocator.getCurrentPosition();
      final coords = "${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
      return coords;
    }
  }

  static Stream<LatLng> getLocationStream() {
    const locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).map((position) => LatLng(position.latitude, position.longitude));
  }
}

@riverpod
Future<LatLng> currentLocation(Ref ref) {
  return LocationService.getCurrentLocation();
}

@riverpod
Future<String?> currentPlacemark(Ref ref) {
  return LocationService.getPlacemark();
}

@riverpod
Stream<LatLng> locationStream(Ref ref) {
  return LocationService.getLocationStream();
}
