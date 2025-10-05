import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:latlong2/latlong.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/map_app_bar.dart";
import "../../../common/widgets/cards/blur_card.dart";
import "../../../common/widgets/cards/vert_card.dart";
import "../../../common/widgets/tile_layer.dart";
import "../../../gen/assets.gen.dart";
import "../../bottom_nav/view/bean_button.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../data/stop.dart";
import "../hooks/use_next_stop_navigation.dart";
import "stops_layer.dart";

class StopsMapView extends HookWidget {
  const StopsMapView({super.key, required this.stops, this.searchText, this.onSearchSubmitted});

  final List<Stop>? stops;
  final String? searchText;
  final ValueChanged<String>? onSearchSubmitted;

  @override
  Widget build(BuildContext context) {
    final activeStop = useState<Stop?>(stops == null || stops!.isEmpty ? null : stops!.first);
    useEffect(() {
      if (stops != null && stops!.isNotEmpty) {
        activeStop.value = stops!.first;
      }
      return null;
    }, [stops]);

    final mapController = useMemoized(MapController.new, []);
    final scrollController = useMemoized(ScrollController.new, []);

    final navigateToSpecificStop = useSpecificStopNavigation(
      stops: stops ?? [],
      activeStop: activeStop,
      mapController: mapController,
      scrollController: scrollController,
    );
    // Use the next stop navigation hook
    final navigateToNextStop = useNextStopNavigation(
      stops: stops ?? [],
      activeStop: activeStop,
      mapController: mapController,
      scrollController: scrollController,
    );
    final initialCenter = useMemoized(() {
      final stopsLocal = stops;
      if (stopsLocal == null || stopsLocal.isEmpty) {
        return const LatLng(50.0645, 19.9830); // tauron arena
      }
      return LatLng(stopsLocal.first.coordinates.latitude, stopsLocal.first.coordinates.longitude);
    }, [stops]);

    useEffect(() {
      if (stops != null) {
        mapController.move(initialCenter, 15);
      }
      return null;
    }, [initialCenter]);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: initialCenter,
              interactionOptions: const InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
            ),

            children: [
              const AppTileLayer(),
              if (stops != null)
                StopMarkersLayer(
                  stops: stops!,
                  onMarkerTap: (index) {
                    final stop = stops![index];
                    mapController.move(stop.coordinates, 16);
                    unawaited(navigateToSpecificStop(stop));
                  },
                ),
            ],
          ),
          // App bar positioned at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MapSingleInputAppBar(searchText: searchText, onSearchSubmitted: onSearchSubmitted),
          ),
          if (stops != null && stops!.isEmpty)
            Center(
              child: BlurCard(
                borderRadius: r18,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("Nie znaleziono przystanków", style: context.textTheme.headlineSmall?.white),
                ),
              ),
            ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClippedBottomNavBar(
              variant: stops != null && stops!.isEmpty
                  ? ClippedBottomNavBarVariant.verySmall
                  : stops == null
                  ? ClippedBottomNavBarVariant.small
                  : ClippedBottomNavBarVariant.normal,
              extraBeanButton: stops == null || stops!.isEmpty
                  ? null
                  : BeanButton(
                      icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white),
                      onTap: navigateToNextStop,
                    ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: StopsBottomList(
              stops: stops,
              activeStop: activeStop,
              mapController: mapController,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}

class StopsBottomList extends StatelessWidget {
  const StopsBottomList({
    super.key,
    required this.stops,
    required this.activeStop,
    required this.mapController,
    required this.scrollController,
  });

  final List<Stop>? stops;
  final ValueNotifier<Stop?> activeStop;
  final MapController mapController;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    List<Widget>? children = stops?.map((stop) {
      final isActive = activeStop.value?.id == stop.id;
      return VertCard(
        isActive: isActive,
        topChild: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text:
                    stop.routes?.map((route) => route.destinations?.length ?? 0).reduce((a, b) => a + b).toString() ??
                    "0",
                style: isActive ? context.textTheme.headlineSmall : context.textTheme.headlineSmall?.white,
              ),
              TextSpan(
                text: "\n Kierunki",
                style: context.textTheme.bodySmall?.withColor(isActive ? Colors.black : Colors.white),
              ),
            ],
          ),
        ),
        bottomIcon: SvgPicture.asset(
          Assets.icons.busStopIcon,
          height: p20,
          colorFilter: isActive
              ? const ColorFilter.mode(Colors.black, BlendMode.srcIn)
              : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        bottomText: "120 m",

        onTap: () async {
          activeStop.value = stop;
          await context.router.push<void>(StopDetailsRoute(id: stop.id.toString()));
        },
        child: Center(
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [TextSpan(text: stop.name, style: context.textTheme.titleLarge?.white)],
            ),
          ),
        ),
      );
    }).toList();

    children ??= List.generate(10, (index) => const VertCardShimmer());
    return SizedBox(
      height: VertCard.heightActive,
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: p8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => children![index],
        itemCount: children.length,
        separatorBuilder: (context, index) => const SizedBox(width: p8),
      ),
    );
  }
}
