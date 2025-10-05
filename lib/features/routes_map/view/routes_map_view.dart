import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/cards/blur_card.dart";
import "../../../common/widgets/cards/vert_card.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../../../common/widgets/inputs/glass_input.dart";
import "../../../common/widgets/pop_button.dart";
import "../../../common/widgets/tile_layer.dart";
import "../../../gen/assets.gen.dart";
import "../../bottom_nav/view/bean_button.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../data/route_response.dart";
import "../hooks/use_route_cycling.dart";
import "../hooks/use_route_map_focus.dart";
import "route_map_polyline_layer.dart";
import "vert_route_card.dart";

class RoutesMapView extends HookWidget {
  const RoutesMapView({super.key, this.routes, required this.fromAddress, required this.toAddress});

  final List<RouteResponse>? routes;
  final ValueNotifier<String> fromAddress;
  final ValueNotifier<String> toAddress;
  @override
  Widget build(BuildContext context) {
    final mapController = useMemoized(MapController.new, []);
    final scrollController = useMemoized(ScrollController.new, []);
    final activeRoute = useState<RouteResponse?>(routes == null || routes!.isEmpty ? null : routes!.first);
    final fromAddressController = useTextEditingController(text: fromAddress.value);
    final toAddressController = useTextEditingController(text: toAddress.value);

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
        Future.delayed(Duration.zero, () {
          mapController.move(initialCenter, 15);
        });
      }
      return null;
    }, [initialCenter]);

    final cycleToNextRoute = useRouteCycling(
      activeRoute: activeRoute,
      routes: routes,
      scrollController: scrollController,
    );

    // Focus map on active route when it changes
    useRouteMapFocus(activeRoute: activeRoute, mapController: mapController);

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
              RouteMapPolylineLayer(route: activeRoute.value),
            ],
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Column(
              spacing: p8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassInput(controller: fromAddressController, onSubmitted: (value) => fromAddress.value = value),
                GlassInput(
                  controller: toAddressController,
                  onSubmitted: (value) => toAddress.value = value,
                  dotIndicatorVariant: DotIndicatorVariant.green,
                ),
                const BlurCard(borderRadius: r18, child: PopButton()),
              ],
            ),
          ),

          if (routes != null && routes!.isEmpty)
            Center(
              child: BlurCard(
                borderRadius: r18,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("Nie znaleziono trasy", style: context.textTheme.headlineSmall?.white),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClippedBottomNavBar(
              showListSwitch: true,
              variant: routes != null && routes!.isEmpty
                  ? ClippedBottomNavBarVariant.verySmall
                  : ClippedBottomNavBarVariant.normal,
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
              onRouteTap: (route) async {
                activeRoute.value = route;
                final router = context.router;
                // Find the index of the selected route and scroll to it
                if (routes != null) {
                  final routeIndex = routes!.indexOf(route);
                  if (routeIndex != -1) {
                    unawaited(useScrollToRoute(scrollController: scrollController, routeIndex: routeIndex));
                  }
                }

                await router.push(RouteTripRoute(route: route));
              },
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
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: VertRouteCard(isActive: isActive, route: route, onTap: () => onRouteTap(route)),
          ),
          if (isActive && route.routes.first.delay == null)
            Positioned(top: 0, left: (167 - 80) / 2, child: Assets.punctualBadge.image(width: 80)),
        ],
      );
    }).toList();

    children ??= List.generate(10, (index) => const VertCardShimmer());

    return SizedBox(
      height: VertCard.heightActive + 30,
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
