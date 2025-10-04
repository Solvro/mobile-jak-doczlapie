import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "data/stop_repository.dart";
import "view/stop_detail_view.dart";

@RoutePage()
class StopDetailsPage extends ConsumerWidget {
  const StopDetailsPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stop = ref.watch(stopRepositoryProvider(id));

    return StopDetailsView(stop: stop.value);
  }
}
