import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../gen/assets.gen.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../../report_incidents/view/report_incidents_btn.dart";
import "../../report_schedule/view/report_schedule_button.dart";

class StopsView extends StatelessWidget {
  const StopsView({super.key, required this.isBigger, required this.locationAddress});

  final bool isBigger;
  final String? locationAddress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClippedBottomNavBar(
            variant: !isBigger ? ClippedBottomNavBarVariant.verySmall : ClippedBottomNavBarVariant.small,
            extraBeanButtonLeft: const ReportScheduleButton(),
          ),
        ),
        if (isBigger)
          Positioned(
            // TODO(simon-the-shark): this is fake
            bottom: 145 + MediaQuery.paddingOf(context).bottom,
            left: MediaQuery.sizeOf(context).width * 0.5 - 85,
            child: Assets.fakeGreenBadge.image(width: 170),
          ),
        Positioned(
          left: 25,
          top: 140,
          right: 27,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Sprawdź jakie linie odjeżdżają z tego przystanku\n",
                  style: context.textTheme.headlineSmall?.white.bold,
                ),
                if (!isBigger)
                  TextSpan(
                    text: "Wpisz nazwę lub lokalizację, w której się znajdujesz, aby wyszukać najbliższe przystanki.",
                    style: context.textTheme.titleMedium?.w400.withColor(const Color(0xFFD4D2CC)),
                  ),
              ],
            ),
          ),
        ),

        // const Positioned(bottom: 110, child: ReportIncidentsBtn()),
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
