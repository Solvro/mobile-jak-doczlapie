import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jak_doczlapie/common/widgets/app_loading_screen.dart';
import 'package:jak_doczlapie/features/home/data/stops_repository.dart';
import 'package:jak_doczlapie/features/home/view/home_view.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stops = ref.watch(stopsRepositoryProvider);
    return switch (stops) {
      AsyncData(:final value) => HomeView(stops: value),
      AsyncLoading() => AppLoadingScreen(),
      _ => Scaffold(),
    };
  }
}
