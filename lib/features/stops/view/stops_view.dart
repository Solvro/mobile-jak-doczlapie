import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../data/stops_repository.dart";
import "../hooks/use_coords.dart";
import "animated_showup_logo.dart";
import "stop_tile.dart";

class StopsView extends HookConsumerWidget {
  const StopsView({super.key, required this.isBigger, required this.locationAddress, required this.isSearched});

  final bool isBigger;
  final String? locationAddress;
  final ValueNotifier<bool> isSearched;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coords = useCoords(locationAddress);

    final stopsAsync = ref.watch(
      stopsRepositoryProvider(
        coords.data?.latitude.toString() != null && isSearched.value
            ? (latitude: coords.data!.latitude.toString(), longitiude: coords.data!.longitude.toString())
            : null,
      ),
    );

    final stops = stopsAsync.value ?? [];
    final isEmpty = !stopsAsync.isLoading && stops.isEmpty;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (isBigger && !isSearched.value) AnimatedShowupLogo(isBigger: isBigger),
        if (isBigger && isEmpty && isSearched.value)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text("Nie znaleziono przystanków", style: context.textTheme.headlineSmall?.white),
            ),
          ),
        if (!isBigger)
          Positioned(
            left: 25,
            top: 150,
            right: 27,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Sprawdź jakie linie odjeżdżają z tego przystanku\n",
                    style: context.textTheme.headlineSmall?.white,
                  ),
                  TextSpan(
                    text: "Wpisz nazwę lub lokalizację, w której się znajdujesz, aby wyszukać najbliższe przystanki.",
                    style: context.textTheme.titleMedium?.w400.withColor(const Color(0xFFD4D2CC)),
                  ),
                ],
              ),
            ),
          ),

        Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: p12),
                shrinkWrap: true,
                itemCount: stops.length,
                itemBuilder: (context, index) => StopTile(stop: stops[index]),
                separatorBuilder: (context, index) => const SizedBox(height: p12),
              ),
            ),
            if (isBigger && !isSearched.value)
              FilledButton(
                onPressed: () {
                  isSearched.value = true;
                },
                child: const Text("POKAŻ PRZYSTANKI"),
              ),
          ],
        ),
      ],
    );
  }
}
