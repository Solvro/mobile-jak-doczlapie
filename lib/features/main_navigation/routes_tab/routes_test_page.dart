import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/simple_logo_app_bar.dart";
import "../../../common/widgets/gradient_scaffold.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";

@RoutePage()
class RoutesTestPage extends HookConsumerWidget {
  const RoutesTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GradientScaffold(
      appBar: SimpleLogoAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_bus, size: 64, color: Colors.white),
            const SizedBox(height: p16),
            const Text(
              "Test Trasy",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: p8),
            const Text("To jest testowa strona dla tabu Trasy", style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: p24),
            ElevatedButton(onPressed: () => context.router.maybePop(), child: const Text("Wróć")),
            const ClippedBottomNavBar(),
          ],
        ),
      ),
    );
  }
}
