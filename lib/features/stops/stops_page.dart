import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../app/router.dart";
import "../../app/tokens.dart";
import "../../common/widgets/bottom_nav_bar.dart";
import "../../common/widgets/gradient_scaffold.dart";
import "../../common/widgets/map_list_switch.dart";
import "../../common/widgets/simple_logo_app_bar.dart";
import "../routes/view/route_view.dart";
import "view/animated_double_circle.dart";
import "view/location_picker_input.dart";
import "view/stops_view.dart";

@RoutePage()
class StopsPage extends HookConsumerWidget {
  const StopsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewType = useState<ViewType>(ViewType.map);
    final selectedTab = useState(1);
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
                child: selectedTab.value == 0
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClippedBottomNavBar(
              currentIndex: selectedTab.value,
              onTap: (index) {
                selectedTab.value = index;
              },
              onViewTypeChange: (type) {
                viewType.value = type;
              },
              viewType: viewType.value,
              isSmall: true,
            ),
          ),
        ],
      ),
    );
  }
}
