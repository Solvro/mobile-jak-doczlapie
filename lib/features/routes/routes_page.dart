import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

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

    return RoutesView(
      isBigger: isBigger,
      searchControllerStart: searchControllerStart,
      locationAddressStart: locationAddressStart,
      searchControllerEnd: searchControllerEnd,
      locationAddressEnd: locationAddressEnd,
    );
  }
}
