import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../stops_map/data/rest_client.dart";
import "route_response.dart";

part "routes_repository.g.dart";

@riverpod
Future<List<RouteResponse>?> routesRepository(
  Ref ref,
  ({double fromLongitude, double fromLatitude, double toLongitude, double toLatitude})? searchParams,
) async {
  if (searchParams == null) {
    return null;
  }

  // Start with radius 1000 and increase step by step
  const initialRadius = 1000;
  const radiusStep = 1000;
  const maxRadius = 10000; // Maximum radius to prevent infinite loops

  for (var radius = initialRadius; radius <= maxRadius; radius += radiusStep) {
    final response = await ref
        .read(restClientProvider)
        .getRoutes(
          searchParams.fromLongitude.toString(),
          searchParams.fromLatitude.toString(),
          searchParams.toLongitude.toString(),
          searchParams.toLatitude.toString(),
          radius.toString(),
        );

    // If we found routes, return them
    if (response.isNotEmpty) {
      return response;
    }
  }

  // If no routes found with any radius, return null
  return null;
}
