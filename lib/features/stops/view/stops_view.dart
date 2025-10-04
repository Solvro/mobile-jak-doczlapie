import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../common/widgets/bottom_nav_bar.dart";
import "../../../common/widgets/map_list_switch.dart";
import "animated_showup_logo.dart";

class StopsView extends StatelessWidget {
  const StopsView({
    super.key,
    required this.isBigger,
    required this.locationAddress,
    required this.selectedTab,
    required this.viewType,
  });

  final bool isBigger;
  final String? locationAddress;
  final ValueNotifier<int> selectedTab;
  final ValueNotifier<ViewType> viewType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (isBigger) AnimatedShowupLogo(isBigger: isBigger),

        // if (isBigger && isEmpty && isSearched.value)
        //   Align(
        //     alignment: Alignment.topCenter,
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 100),
        //       child: Text("Nie znaleziono przystanków", style: context.textTheme.headlineSmall?.white),
        //     ),
        //   ),
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
            isSmall: !isBigger,
          ),
        ),
        if (!isBigger)
          Positioned(
            left: 25,
            top: 150,
            right: 27,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Sprawdź jakie linie odjeżdżają z tego przystanku\n",
                    style: context.textTheme.headlineSmall?.white,
                  ),
                  TextSpan(
                    text: "Wpisz nazwę lub lokalizację, w której się znajdujesz, aby wyszukać najbliższe przystanki.",
                    style: context.textTheme.titleMedium?.w400.withColor(const Color(0xFFD4D2CC)),
                  ),
                ],
              ),
            ),
          ),

        if (isBigger)
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: FilledButton(
              onPressed: () async {
                final locationAddress = this.locationAddress;
                if (locationAddress == null) return;
                await context.router.push(StopsMapRoute(address: locationAddress));
              },
              child: const Text("POKAŻ PRZYSTANKI"),
            ),
          ),
      ],
    );
  }
}
