import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/app_bar.dart";
import "../../../common/widgets/bottom_nav_bar.dart";
import "../../../common/widgets/gradient_scaffold.dart";
import "../../../common/widgets/map_list_switch.dart";

@RoutePage()
class RouteView extends StatelessWidget {
  const RouteView({super.key, required this.selectedTab, required this.viewType});
  final ValueNotifier<int> selectedTab;
  final ValueNotifier<ViewType> viewType;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientScaffold(
          appBar: CommonAppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.route, size: 64, color: Colors.white),
                SizedBox(height: p16),
                Text(
                  "Trasa",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: p8),
                Text("Funkcja w trakcie rozwoju", style: TextStyle(color: Colors.white70, fontSize: 16)),
              ],
            ),
          ),
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
    );
  }
}
