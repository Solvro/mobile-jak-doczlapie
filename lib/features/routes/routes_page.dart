import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../app/tokens.dart";

import "../../common/widgets/app_bars/simple_logo_app_bar.dart";
import "../../common/widgets/calendar_button.dart";
import "../../common/widgets/dot_indicator.dart";
import "../../common/widgets/gradient_scaffold.dart";
import "../../common/widgets/my_input.dart";
import "../stops/view/animated_double_circle.dart";
import "../stops/view/location_picker_input.dart";
import "view/routes_view.dart";

@RoutePage()
class RoutesPage extends HookConsumerWidget {
  const RoutesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAddressStart = useState<String?>(null);
    final locationAddressEnd = useState<String?>(null);
    final isBigger =
        (locationAddressStart.value?.isNotEmpty ?? false) && (locationAddressEnd.value?.isNotEmpty ?? false);
    final searchControllerStart = useTextEditingController();
    final searchControllerEnd = useTextEditingController();

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
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: p4),
                          LocationPickerInput(
                            controller: searchControllerStart,
                            onChanged: (text) {
                              locationAddressStart.value = text;
                            },
                            hintText: "Skąd jedziemy?",
                            variant: MyInputVariant.dense,
                          ),
                          MyInput(
                            controller: searchControllerEnd,
                            onChanged: (text) {
                              locationAddressEnd.value = text;
                            },
                            hintText: "Dokąd jedziemy?",
                            variant: MyInputVariant.dense,
                            dotIndicatorVariant: DotIndicatorVariant.blue,
                          ),
                          const Row(mainAxisAlignment: MainAxisAlignment.end, children: [CalendarButton()]),
                          const SizedBox(height: p4),
                        ],
                      ),
                    ),
                    Expanded(child: RoutesView(isBigger: isBigger)),
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
