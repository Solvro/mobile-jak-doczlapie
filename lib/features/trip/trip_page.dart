import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../common/widgets/app_loading_screen.dart";
import "data/trip_repository.dart";
import "view/trip_view.dart";

@RoutePage()
class TripPage extends ConsumerWidget {
  const TripPage({super.key, required this.lineId, required this.runId, required this.direction});

  final String lineId;
  final int runId;
  final String direction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final line = ref.watch(tripRepositoryProvider(lineId, runId, direction));
    return switch (line) {
      AsyncData(:final value) => TripView(trip: value),
      AsyncLoading() => const AppLoadingScreen(),
      _ => const Scaffold(),
    };
  }
}
