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
import "line_polyline_layer.dart";

typedef LineWithDestination = ({Line line, String destination});

class StopDetailsView extends HookWidget {
  const StopDetailsView({super.key, required this.stop});

  final Stop? stop;

  @override
  Widget build(BuildContext context) {
    final mapController = useMemoized(MapController.new, []);
    final scrollController = useMemoized(ScrollController.new, []);
    final activeLine = useState<LineWithDestination?>(
      stop?.routes?.first != null
          ? (line: stop!.routes!.first, destination: stop?.routes?.first.destinations?.first ?? "")
          : null,
    );

    useEffect(() {
      if (stop != null) {
        activeLine.value = stop?.routes?.first != null
            ? (line: stop!.routes!.first, destination: stop?.routes?.first.destinations?.first ?? "")
            : null;
      }
      return null;
    }, [stop]);

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

            children: [
              const AppTileLayer(),
              LinePolylineLayer(line: activeLine.value),
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
            child: StopDetailBottomList(
              stop: stop,
              activeLine: activeLine,
              mapController: mapController,
              scrollController: scrollController,
            ),
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
    required this.activeLine,
    required this.mapController,
    required this.scrollController,
  });

  final Stop? stop;

  final MapController mapController;
  final ScrollController scrollController;

  final ValueNotifier<LineWithDestination?> activeLine;

  @override
  Widget build(BuildContext context) {
    List<Widget>? children = stop?.routes
        ?.map((line) {
          return line.destinations?.map<Widget>((destination) {
            final isActive = activeLine.value?.line.id == line.id && activeLine.value?.destination == destination;
            return SingleDestinationVertTile(
              isActive: isActive,
              line: line,
              direction: destination,
              onTap: () {
                activeLine.value = (line: line, destination: destination);
              },
            );
          }).toList();
        })
        .expand((element) => element ?? <Widget>[])
        .toList();

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
  const SingleDestinationVertTile({
    super.key,
    required this.isActive,
    required this.line,
    required this.direction,
    required this.onTap,
  });

  final bool isActive;
  final Line line;
  final String direction;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final firstDepartureTime = useFirstDepartureTime(line.schedules ?? [], direction);
    return VertCard(
      isActive: isActive,
      topChild: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: "Kierunek\n",
              style: context.textTheme.bodySmall?.withColor(isActive ? Colors.black : Colors.white),
            ),
            TextSpan(
              text: direction,
              style: isActive ? context.textTheme.titleLarge : context.textTheme.titleLarge?.white,
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
      onTap: onTap,
      child: Center(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(text: "Odjazd\n", style: context.textTheme.bodySmall?.white),
              TextSpan(
                text: "${firstDepartureTime.split(":").first}:${firstDepartureTime.split(":")[1]}",
                style: context.textTheme.headlineLarge?.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
