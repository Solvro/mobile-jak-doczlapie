import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "../../../app/tokens.dart";
import "../calendar_button.dart";
import "../dot_indicator.dart";
import "../inputs/my_input.dart";
import "../pop_button.dart";

class RouteListAppBar extends HookWidget implements PreferredSizeWidget {
  const RouteListAppBar({super.key, required this.fromAddress, required this.toAddress});
  final ValueNotifier<String> fromAddress;
  final ValueNotifier<String> toAddress;

  @override
  Widget build(BuildContext context) {
    final searchController1 = useTextEditingController(text: fromAddress.value);
    final searchController2 = useTextEditingController(text: toAddress.value);

    return ColoredBox(
      color: lightBlueGradientPoint,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: p12),
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: p4),
              MyInput(
                controller: searchController1,
                onSubmitted: (text) {
                  fromAddress.value = text;
                },
                variant: MyInputVariant.dense,
              ),
              MyInput(
                controller: searchController2,
                onSubmitted: (text) {
                  toAddress.value = text;
                },
                variant: MyInputVariant.dense,
                dotIndicatorVariant: DotIndicatorVariant.green,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [PopButton(), CalendarButton(readonly: false)],
              ),
              const SizedBox(height: p4),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 170);
}
