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

  final response = await ref
      .read(restClientProvider)
      .getRoutes(
        searchParams.fromLongitude.toString(),
        searchParams.fromLatitude.toString(),
        searchParams.toLongitude.toString(),
        searchParams.toLatitude.toString(),
        "5000",
      );

  return response;
}
