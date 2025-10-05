import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../common/widgets/app_loading_screen.dart";
import "data/trip_repository.dart";

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
      AsyncData(:final value) => /* TripView(route: value)*/ const Scaffold(body: Center(child: Text("placehosdler"))),
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
