import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jak_doczlapie/common/widgets/app_loading_screen.dart';
import 'package:jak_doczlapie/features/stop_details/data/stop_repository.dart';
import 'package:jak_doczlapie/features/stop_details/view/stop_details_view.dart';

@RoutePage()
class StopDetailsPage extends ConsumerWidget {
  const StopDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stop = ref.watch(stopRepositoryProvider(id));
    return switch (stop) {
      AsyncData(:final value) => StopDetailsView(stop: value),
      AsyncLoading() => AppLoadingScreen(),
      _ => Scaffold(),
    };
  }
}
