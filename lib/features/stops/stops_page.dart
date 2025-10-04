import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../app/router.dart" show StopsMapRoute;
import "../../app/tokens.dart";
import "../../common/widgets/gradient_scaffold.dart";

import "../../common/widgets/app_bars/simple_logo_app_bar.dart";
import "../bottom_nav/domain/bottom_nav_controller.dart";
import "../routes/view/route_view.dart";
import "view/animated_double_circle.dart";
import "view/location_picker_input.dart";
import "view/stops_view.dart";

@RoutePage()
class StopsPage extends HookConsumerWidget {
  const StopsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(bottomNavControllerProvider);
    final locationAddress = useState<String?>(null);
    final isBigger = locationAddress.value?.isNotEmpty ?? false;
    final searchController = useTextEditingController();

    return GradientScaffold(
      safeArea: false,
      body: Stack(
        children: [
          AnimatedDoubleCircle(isBigger: isBigger),
          Column(
            children: [
              SimpleLogoAppBar(),
              Expanded(
                child: selectedTab == 0
                    ? const RouteView()
                    : Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: p16),
                            child: LocationPickerInput(
                              controller: searchController,
                              onChanged: (value) {
                                locationAddress.value = value;
                              },
                              onSubmitted: (value) async {
                                locationAddress.value = value;
                                await context.router.push(StopsMapRoute(address: value));
                              },
                            ),
                          ),
                          Expanded(
                            child: StopsView(isBigger: isBigger, locationAddress: locationAddress.value),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
