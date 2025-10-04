import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "animated_showup_logo.dart";

class StopsView extends StatelessWidget {
  const StopsView({super.key, required this.isBigger, required this.locationAddress});

  final bool isBigger;
  final String? locationAddress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (isBigger) AnimatedShowupLogo(isBigger: isBigger),
        Positioned(bottom: 0, left: 0, right: 0, child: ClippedBottomNavBar(isSmall: !isBigger)),
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
                    style: context.textTheme.headlineSmall?.white.bold,
                  ),
                  TextSpan(
                    text: "Wpisz nazwę lub lokalizację, w której się znajdujesz, aby wyszukać najbliższe przystanki.",
                    style: context.textTheme.titleMedium?.w400.withColor(const Color(0xFFD4D2CC)),
                  ),
                ],
              ),
            ),
          ),

        Positioned(
          bottom: 110,
          left: 0,
          right: 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isBigger
                ? FilledButton(
                    onPressed: () async {
                      final locationAddress = this.locationAddress;
                      if (locationAddress == null) return;
                      await context.router.push(StopsMapRoute(address: locationAddress));
                    },
                    child: const Text("POKAŻ PRZYSTANKI"),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
