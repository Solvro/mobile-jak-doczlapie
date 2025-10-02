import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../common/widgets/app_loading_screen.dart";
import "../stop_details/hooks/use_sorted_departures.dart";
import "data/trip_repository.dart";
import "view/trip_view.dart";

@RoutePage()
class TripPage extends ConsumerWidget {
  const TripPage({super.key, required this.lineNumber, required this.startingDeparture});

  final String lineNumber;
  final DepartureWithDirection startingDeparture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stops = ref.watch(tripRepositoryProvider(lineNumber, startingDeparture));
    return switch (stops) {
      AsyncData(:final value) => TripView(trip: value),
      AsyncLoading() => const AppLoadingScreen(),
      _ => const Scaffold(),
    };
  }
}
