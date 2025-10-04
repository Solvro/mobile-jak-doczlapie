import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "view/route_detail_view.dart";

@RoutePage()
class RouteDetailsPage extends ConsumerWidget {
  const RouteDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const RouteDetailsView();
  }
}
