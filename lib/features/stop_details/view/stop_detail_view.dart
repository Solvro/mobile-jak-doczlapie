import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:latlong2/latlong.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/map_app_bar.dart";
import "../../../common/widgets/cards/vert_card.dart";
import "../../../common/widgets/tile_layer.dart";
import "../../../gen/assets.gen.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../../stops_map/data/line.dart";
import "../../stops_map/data/stop.dart";
import "../hooks/use_first_departure_time.dart";

class StopDetailsView extends HookWidget {
  const StopDetailsView({super.key, required this.stop});

  final Stop? stop;

  @override
  Widget build(BuildContext context) {
    final mapController = useMemoized(MapController.new, []);
    final scrollController = useMemoized(ScrollController.new, []);

    // final navigateToSpecificStop = useSpecificStopNavigation(
    //   stops: stops ?? [],
    //   activeStop: activeStop,
    //   mapController: mapController,
    //   scrollController: scrollController,
    // );
    // // Use the next stop navigation hook
    // final navigateToNextStop = useNextStopNavigation(
    //   stops: stops ?? [],
    //   activeStop: activeStop,
    //   mapController: mapController,
    //   scrollController: scrollController,
    // );
    final initialCenter = useMemoized(() {
      final stopLocal = stop;
      if (stopLocal == null) {
        return const LatLng(50.0645, 19.9830); // tauron arena
      }
      return stopLocal.coordinates;
    }, [stop]);

    useEffect(() {
      if (stop != null) {
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

            children: const [
              AppTileLayer(),
              // if (stop != null)
              //   StopMarkersLayer(
              //     stops: stops!,
              //     onMarkerTap: (index) {
              //       final stop = stops![index];
              //       mapController.move(stop.coordinates, 16);
              //       unawaited(navigateToSpecificStop(stop));
              //     },
              //   ),
            ],
          ),
          // App bar positioned at the top
          if (stop != null)
            Positioned(top: 0, left: 0, right: 0, child: MapAppBar(searchText: stop?.name, isReadonly: true)),
          if (stop == null) const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClippedBottomNavBar(
              isSmall: stop == null,
              // extraBeanButton: stop == null
              //     ? null
              //     : BeanButton(
              //         icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white),
              //         onTap: navigateToNextStop,
              //       ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: StopDetailBottomList(stop: stop, mapController: mapController, scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}

class StopDetailBottomList extends StatelessWidget {
  const StopDetailBottomList({
    super.key,
    required this.stop,

    required this.mapController,
    required this.scrollController,
  });

  final Stop? stop;

  final MapController mapController;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    List<Widget>? children = stop?.routes?.map((line) {
      const isActive = false;
      return SingleDestinationVertTile(isActive: isActive, line: line);
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

class SingleDestinationVertTile extends HookWidget {
  const SingleDestinationVertTile({super.key, required this.isActive, required this.line});

  final bool isActive;
  final Line line;
  @override
  Widget build(BuildContext context) {
    final firstDepartureTime = useFirstDepartureTime(line.schedules ?? [], line.destinations?.first ?? "");
    return VertCard(
      topChild: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: "Kierunek\n",
              style: context.textTheme.bodySmall?.withColor(isActive ? Colors.black : Colors.white),
            ),
            TextSpan(
              text: line.destinations?.first ?? "<><>",
              style: isActive ? context.textTheme.headlineSmall : context.textTheme.headlineSmall?.white,
            ),
          ],
        ),
      ),
      bottomIcon: SvgPicture.asset(
        Assets.icons.busVechicleIcon,
        height: p20,
        colorFilter: isActive
            ? const ColorFilter.mode(Colors.black, BlendMode.srcIn)
            : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      bottomText: "${line.stops?.length.toString() ?? "0"} przystanków",

      onTap: () {},
      child: Center(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(text: "Odjazd\n", style: context.textTheme.titleLarge?.white),
              TextSpan(text: firstDepartureTime, style: context.textTheme.titleLarge?.white),
            ],
          ),
        ),
      ),
    );
  }
}
