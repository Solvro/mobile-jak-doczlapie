import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../../app/router.dart";
import "../../../common/services/location_service.dart";
import "../../../common/widgets/app_bar.dart";
import "../data/stop.dart";
import "stop_tile.dart";

class StopsView extends HookConsumerWidget {
  const StopsView({super.key, required this.stops});

  final List<Stop> stops;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    return Scaffold(
      appBar: CommonAppBar(
        title: "Przystanki",
        actions: [
          IconButton(
            onPressed: () => context.router.push(const ReportScheduleRoute()),
            icon: const Icon(Icons.feedback),
          ),
        ],
      ),
      body: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(child: TextField(controller: controller)),
              IconButton.filled(
                onPressed: () async {
                  await LocationService.requestPermission();
                  final placemark = await ref.read(currentPlacemarkProvider.future);
                  controller.text = placemark ?? "";
                },
                icon: const Icon(Icons.place),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: stops.length,
            itemBuilder: (context, index) => StopTile(stop: stops[index]),
          ),
        ],
      ),
    );
  }
}
