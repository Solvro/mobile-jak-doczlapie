import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/app_loading_screen.dart";
import "../data/stops_repository.dart";
import "../hooks/use_coords.dart";
import "stop_tile.dart";

class StopsView extends HookConsumerWidget {
  const StopsView({super.key, required this.isBigger, required this.locationAddress});

  final bool isBigger;
  final String? locationAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coords = useCoords(locationAddress);

    final stopsAsync = ref.watch(
      stopsRepositoryProvider(
        coords.data?.latitude.toString() != null
            ? (latitude: coords.data!.latitude.toString(), longitiude: coords.data!.longitude.toString())
            : null,
      ),
    );
    return switch (stopsAsync) {
      AsyncData(:final value) => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: p12),
        shrinkWrap: true,
        itemCount: value.length,
        itemBuilder: (context, index) => StopTile(stop: value[index]),
        separatorBuilder: (context, index) => const SizedBox(height: p12),
      ),
      AsyncLoading() => const AppLoadingScreen(),
      _ => const Scaffold(),
    };
  }
}
