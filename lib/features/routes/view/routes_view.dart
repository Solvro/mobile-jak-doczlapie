import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/simple_logo_app_bar.dart";
import "../../../common/widgets/calendar_button.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../../../common/widgets/gradient_scaffold.dart";
import "../../../common/widgets/inputs/my_input.dart";
import "../../../gen/assets.gen.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../../stops/view/animated_double_circle.dart";
import "../../stops/view/location_picker_input.dart";

class RoutesView extends StatelessWidget {
  const RoutesView({
    super.key,
    required this.isBigger,
    required this.searchControllerStart,
    required this.locationAddressStart,
    required this.searchControllerEnd,
    required this.locationAddressEnd,
  });

  final bool isBigger;
  final TextEditingController searchControllerStart;
  final ValueNotifier<String?> locationAddressStart;
  final TextEditingController searchControllerEnd;
  final ValueNotifier<String?> locationAddressEnd;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      safeArea: false,
      body: Stack(
        children: [
          AnimatedDoubleCircle(isBigger: isBigger),
          Column(
            children: [
              SimpleLogoAppBar(),
              Expanded(
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: p16),
                      child: Column(
                        spacing: p12,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: p4),
                          LocationPickerInput(
                            controller: searchControllerStart,
                            onChanged: (text) {
                              locationAddressStart.value = text;
                            },
                            onSubmitted: (text) async {
                              locationAddressStart.value = text;
                              if (isBigger) {
                                await context.router.push(
                                  RouteDetailsRoute(
                                    fromAddress: locationAddressStart.value!,
                                    toAddress: locationAddressEnd.value!,
                                  ),
                                );
                              }
                            },
                            hintText: "Skąd jedziemy?",
                            variant: MyInputVariant.dense,
                          ),
                          MyInput(
                            controller: searchControllerEnd,
                            onChanged: (text) {
                              locationAddressEnd.value = text;
                            },
                            onSubmitted: (text) async {
                              locationAddressEnd.value = text;
                              if (isBigger) {
                                await context.router.push(
                                  RouteDetailsRoute(
                                    fromAddress: locationAddressStart.value!,
                                    toAddress: locationAddressEnd.value!,
                                  ),
                                );
                              }
                            },
                            hintText: "Dokąd jedziemy?",
                            variant: MyInputVariant.dense,
                            dotIndicatorVariant: DotIndicatorVariant.green,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [CalendarButton(readonly: false)],
                          ),
                          const SizedBox(height: p4),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RoutesViewContent(
                        isBigger: isBigger,
                        fromAddress: locationAddressStart.value,
                        toAddress: locationAddressEnd.value,
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

class RoutesViewContent extends StatelessWidget {
  const RoutesViewContent({super.key, required this.isBigger, required this.fromAddress, required this.toAddress});

  final bool isBigger;
  final String? fromAddress;
  final String? toAddress;
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
            variant: isBigger ? ClippedBottomNavBarVariant.small : ClippedBottomNavBarVariant.verySmall,
          ),
        ),
        if (isBigger)
          Positioned(
            bottom: 145 + MediaQuery.paddingOf(context).bottom,
            left: MediaQuery.sizeOf(context).width * 0.5 - 85,
            child: Assets.fakeGreenBadge.image(width: 170),
          ),
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
                      await context.router.push(RouteDetailsRoute(fromAddress: fromAddress!, toAddress: toAddress!));
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
