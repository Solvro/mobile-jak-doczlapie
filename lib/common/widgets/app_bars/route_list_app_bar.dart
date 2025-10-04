import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "../../../app/tokens.dart";
import "../calendar_button.dart";
import "../dot_indicator.dart";
import "../inputs/my_input.dart";
import "../pop_button.dart";

class RouteListAppBar extends HookWidget implements PreferredSizeWidget {
  const RouteListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

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
              MyInput(controller: searchController, onSubmitted: (text) {}, variant: MyInputVariant.dense),
              MyInput(
                controller: searchController,
                onSubmitted: (text) {},
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
