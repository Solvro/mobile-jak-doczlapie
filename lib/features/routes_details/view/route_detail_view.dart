import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:glass/glass.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:latlong2/latlong.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/map_app_bar.dart";
import "../../../common/widgets/cards/blur_card.dart";
import "../../../common/widgets/cards/vert_card.dart";
import "../../../common/widgets/my_input.dart";
import "../../../common/widgets/tile_layer.dart";
import "../../../gen/assets.gen.dart";
import "../../bottom_nav/view/bean_button.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../../stops_map/data/line.dart";
import "../../stops_map/data/stop.dart";
import "../../trip/data/trip_repository.dart";
import "line_polyline_layer.dart";

class RouteDetailsView extends HookWidget {
  const RouteDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = useMemoized(MapController.new, []);
    final scrollController = useMemoized(ScrollController.new, []);
    // final activeLine = useState<LineWithDestination?>(
    //   stop?.routes?.first != null
    //       ? (line: stop!.routes!.first, destination: stop?.routes?.first.destinations?.first ?? "")
    //       : null,
    // );

    // useEffect(() {
    //   if (stop != null) {
    //     activeLine.value = stop?.routes?.first != null
    //         ? (line: stop!.routes!.first, destination: stop?.routes?.first.destinations?.first ?? "")
    //         : null;
    //   }
    //   return null;
    // }, [stop]);

    // final initialCenter = useMemoized(() {
    //   final stopLocal = stop;
    //   if (stopLocal == null) {
    //     return const LatLng(50.0645, 19.9830); // tauron arena
    //   }
    //   return stopLocal.coordinates;
    // }, [stop]);

    // useEffect(() {
    //   if (stop != null) {
    //     mapController.move(initialCenter, 15);
    //   }
    //   return null;
    // }, [initialCenter]);

    // final cycleToNextLine = useLineCycling(activeLine: activeLine, routes: stop?.routes);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: LatLng(50.0645, 19.9830),
              interactionOptions: InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
            ),

            children: const [
              AppTileLayer(),
              // LinePolylineLayer(line: activeLine.value),
            ],
          ),
          // App bar positioned at the top
          // if (stop != null)
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: BlurCard(
              borderRadius: r18,
              child: MyInput(
                controller: TextEditingController(),
                onSubmitted: (text) {},
                variant: MyInputVariant.dense,
                transparent: true,
              ),
            ),
          ),
          // if (stop == null) const Center(child: CircularProgressIndicator()),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClippedBottomNavBar(
              // isSmall: stop == null,
              // extraBeanButton: stop == null
              //     ? null
              //     : BeanButton(
              //         icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white),
              //         onTap: cycleToNextLine,
              //       ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: RoutesBottomList(
              mapController: mapController,
              scrollController: scrollController,
              routes: const [
                (
                  startTime: "10:00",
                  endTime: "11:00",
                  segments: [(lineNumber: "1"), (lineNumber: "IC")],
                  totalTime: "1h",
                ),
                (startTime: "11:00", endTime: "12:00", segments: [(lineNumber: "IC")], totalTime: "1h"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef Segment = ({String lineNumber});

typedef Route = ({String startTime, String endTime, List<Segment> segments, String totalTime});

class RoutesBottomList extends StatelessWidget {
  const RoutesBottomList({
    super.key,
    required this.mapController,
    required this.scrollController,
    required this.routes,
  });

  final MapController mapController;
  final ScrollController scrollController;
  final List<Route> routes;
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = routes.map((route) {
      const isActive = true;
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
        bottomText: "",

        onTap: () {},
        child: Center(
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [TextSpan(text: "Odjazd\n", style: context.textTheme.bodySmall?.white)],
            ),
          ),
        ),
      );
    }).toList();

    // children ??= List.generate(10, (index) => const VertCardShimmer());
    return SizedBox(
      height: VertCard.heightActive,
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: p8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => children[index],
        itemCount: children.length,
        separatorBuilder: (context, index) => const SizedBox(width: p8),
      ),
    );
  }
}
