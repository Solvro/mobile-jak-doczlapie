import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../common/widgets/app_loading_screen.dart";
import "../routes_map/data/route_response.dart";
import "data/trip_repository.dart";
import "view/trip_view.dart";

@RoutePage()
class TripPage extends ConsumerWidget {
  const TripPage({
    super.key,
    required this.lineId,
    required this.runId,
    required this.direction,
    required this.firstDepartureTime,
  });

  final String lineId;
  final int runId;
  final String direction;
  final String firstDepartureTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final line = ref.watch(tripRepositoryProvider(lineId, runId, direction));
    return switch (line) {
      AsyncData(:final value) => TripAdapter(trip: value, firstDepartureTime: firstDepartureTime),
      AsyncLoading() => const AppLoadingScreen(),
      AsyncError(:final error, :final stackTrace) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                "Błąd: $error",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text("Stack trace: $stackTrace", style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    };
  }
}

class TripAdapter extends StatelessWidget {
  const TripAdapter({super.key, required this.trip, required this.firstDepartureTime});
  final Trip trip;
  final String firstDepartureTime;

  @override
  Widget build(BuildContext context) {
    final route = RouteResponse(
      departure: RouteStop(
        name: trip.stops.first.name,
        coordinates: trip.stops.first.coordinates,
        time: firstDepartureTime,
        id: 0,
        distance: 0,
      ),
      arrival: RouteStop(
        name: trip.stops.last.name,
        coordinates: trip.stops.last.coordinates,
        time: trip.stops.last.time,
        id: 0,
        distance: 0,
      ),
      travelTime: 60,
      transfers: 0,
      routes: [
        Segment(
          id: 0,
          name: trip.name,
          operator: trip.operator,
          type: trip.type,
          run: trip.run,
          stops: trip.stops.asMap().entries.map((entry) {
            final index = entry.key;
            final stop = entry.value;
            return RouteStop(
              name: stop.name,
              coordinates: stop.coordinates,
              time: index == 0 ? firstDepartureTime : stop.time,
              id: 0,
              distance: null,
            );
          }).toList(),
          travelTime: 60,
          destination: trip.direction,
          reports: [],
        ),
      ],
    );
    return TripView(route: route);
  }
}
