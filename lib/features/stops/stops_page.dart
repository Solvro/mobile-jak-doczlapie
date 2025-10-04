import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../app/tokens.dart";
import "../../common/widgets/custom_tab_bar.dart";
import "../../common/widgets/gradient_scaffold.dart";
import "../routes/view/route_view.dart";
import "hooks/use_is_searched.dart";
import "view/animated_double_circle.dart";
import "view/location_picker_input.dart";
import "view/stops_view.dart";

@RoutePage()
class StopsPage extends HookConsumerWidget {
  const StopsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(1);
    final locationAddress = useState<String?>(null);
    final isBigger = locationAddress.value?.isNotEmpty ?? false;
    final searchController = useTextEditingController();
    final isSearched = useIsSearched(locationAddress.value ?? "");

    return GradientScaffold(
      body: Stack(
        children: [
          AnimatedDoubleCircle(isBigger: isBigger),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(p16),
                child: CustomTabBar(
                  selectedIndex: selectedTab.value,
                  onTabChanged: (index) => selectedTab.value = index,
                ),
              ),
              // Content based on selected tab
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
                              onSubmitted: (value) {
                                locationAddress.value = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: StopsView(
                              isBigger: isBigger,
                              locationAddress: locationAddress.value,
                              isSearched: isSearched,
                            ),
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
