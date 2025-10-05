import "package:geolocator/geolocator.dart";
import "package:latlong2/latlong.dart";

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

  static Stream<LatLng> getLocationStream() {
    const locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).map((position) => LatLng(position.latitude, position.longitude));
  }
}
