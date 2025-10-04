import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:latlong2/latlong.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/bean_button.dart";
import "../../../common/widgets/bottom_nav_bar.dart";
import "../../../common/widgets/cards/blur_card.dart";
import "../../../common/widgets/cards/vert_card.dart";
import "../../../common/widgets/tile_layer.dart";
import "../../../gen/assets.gen.dart";
import "../data/stop.dart";
import "../hooks/use_next_stop_navigation.dart";
import "map_app_bar.dart";
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
        mapController.moveAndRotate(initialCenter, 15, 0);
      }
      return null;
    }, [initialCenter]);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(initialCenter: initialCenter),
            children: [
              const AppTileLayer(),
              if (stops != null)
                StopMarkersLayer(
                  stops: stops!,
                  onMarkerTap: (index) {
                    final stop = stops![index];
                    mapController.moveAndRotate(stop.coordinates, 16, 0);
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
            child: MapAppBar(searchText: searchText, onSearchSubmitted: onSearchSubmitted),
          ),
          if (stops == null) const Center(child: CircularProgressIndicator()),
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
              isSmall: stops == null || stops!.isEmpty,
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
                text: stop.routes?.length.toString() ?? "0",
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
          Assets.icons.busIcon,
          height: p20,
          colorFilter: isActive
              ? const ColorFilter.mode(Colors.black, BlendMode.srcIn)
              : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        bottomText: "120 m",

        onTap: () {
          // todo: navigation logic
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
