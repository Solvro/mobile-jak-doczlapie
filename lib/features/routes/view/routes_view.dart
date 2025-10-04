import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";

class RoutesView extends StatelessWidget {
  const RoutesView({super.key, required this.isBigger});

  final bool isBigger;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(bottom: 0, left: 0, right: 0, child: ClippedBottomNavBar(isSmall: !isBigger)),
        Positioned(
          left: 25,
          top: 55,
          right: 27,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: isBigger
                      ? "Śledź swój przejazd na bieżąco i unikaj niespodzianek!"
                      : "Sprawdź, jak najłatwiej dotrzeć do punktu docelowego.\n",
                  style: context.textTheme.headlineSmall?.white.bold,
                ),
                if (!isBigger)
                  TextSpan(
                    text: "Znajdziesz tu trasy autobusów przejeżdżających przez miasta i wsie w Twojej okolicy.",
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
                      // final locationAddress = this.locationAddress;
                      // if (locationAddress == null) return;
                      // await context.router.push(StopsMapRoute(address: locationAddress));
                    },
                    child: const Text("POKAŻ TRASY"),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
