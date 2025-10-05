import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/cards/blur_card.dart";
import "../../../common/widgets/cards/vert_card.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../../../common/widgets/inputs/glass_input.dart";
import "../../../common/widgets/pop_button.dart";
import "../../../common/widgets/tile_layer.dart";
import "../../bottom_nav/view/bean_button.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../data/route_response.dart";
import "../hooks/use_route_cycling.dart";
import "vert_route_card.dart";

class RouteDetailsView extends HookWidget {
  const RouteDetailsView({super.key, this.routes});

  final List<RouteResponse>? routes;

  @override
  Widget build(BuildContext context) {
    final mapController = useMemoized(MapController.new, []);
    final scrollController = useMemoized(ScrollController.new, []);
    final activeRoute = useState<RouteResponse?>(routes?.first);

    useEffect(() {
      if (routes != null && routes!.isNotEmpty) {
        activeRoute.value = routes?.first;
      }
      return null;
    }, [routes]);

    final initialCenter = useMemoized(() {
      final stopLocal = routes;
      if (stopLocal == null || stopLocal.isEmpty) {
        return const LatLng(50.0645, 19.9830); // tauron arena
      }
      return stopLocal.first.departure.coordinates;
    }, [routes]);

    useEffect(() {
      if (routes != null) {
        mapController.move(initialCenter, 15);
      }
      return null;
    }, [initialCenter]);

    final cycleToNextRoute = useRouteCycling(activeRoute: activeRoute, routes: routes);

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
              // LinePolylineLayer(line: activeLine.value),
            ],
          ),
          const Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Column(
              spacing: p8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassReadonlyInput(initialText: "Route start"),
                GlassReadonlyInput(initialText: "Route end", dotIndicatorVariant: DotIndicatorVariant.green),
                BlurCard(borderRadius: r18, child: PopButton()),
              ],
            ),
          ),

          if (routes == null) const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClippedBottomNavBar(
              extraBeanButton: BeanButton(
                icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white),
                onTap: cycleToNextRoute,
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: RoutesBottomList(
              mapController: mapController,
              scrollController: scrollController,
              routes: routes,
              activeRoute: activeRoute,
              onRouteTap: (route) => activeRoute.value = route,
            ),
          ),
        ],
      ),
    );
  }
}

class RoutesBottomList extends StatelessWidget {
  const RoutesBottomList({
    super.key,
    required this.mapController,
    required this.scrollController,
    required this.routes,
    required this.activeRoute,
    required this.onRouteTap,
  });

  final MapController mapController;
  final ScrollController scrollController;
  final List<RouteResponse>? routes;
  final ValueNotifier<RouteResponse?> activeRoute;
  final void Function(RouteResponse) onRouteTap;
  @override
  Widget build(BuildContext context) {
    List<Widget>? children = routes?.map((route) {
      final isActive = activeRoute.value == route;
      return VertRouteCard(isActive: isActive, route: route, onTap: () => onRouteTap(route));
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
