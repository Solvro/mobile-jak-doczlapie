import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/pop_button.dart";
import "../../../config/sheet_config.dart";
import "../data/trip_repository.dart";
import "report_button.dart";
import "route_polyline_layer.dart";
import "stop_markers_layer.dart";
import "track_button.dart";
import "trip_bottom_sheet.dart";

class TripView extends HookWidget {
  const TripView({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final mapController = useMemoized(MapController.new, []);
    final draggableController = useMemoized(DraggableScrollableController.new, []);
    final initialCenter = useMemoized(() {
      if (trip.stops.isEmpty) {
        return const LatLng(50.0645, 19.9830); // tauron arena
      }
      final firstStop = trip.stops.first;
      return LatLng(firstStop.coordinates.latitude, firstStop.coordinates.longitude);
    }, [trip.stops]);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(initialCenter: initialCenter),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "pl.solvro.jak_doczlapie",
              ),
              RoutePolylineLayer(trip: trip),
              StopMarkersLayer(
                trip: trip,
                onMarkerTap: (index) async {
                  final stop = trip.stops[index];
                  mapController.moveAndRotate(stop.coordinates, 20, 0);
                  await draggableController.animateTo(
                    defaultSheetConfig.baseSize,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
              const Positioned(top: p64, left: p16, child: PopButton()),
            ],
          ),
          TripBottomSheet(
            trip: trip,
            draggableController: draggableController,
            onStopTap: (index) async {
              final stop = trip.stops[index];
              mapController.move(stop.coordinates, 20);
              await draggableController.animateTo(
                defaultSheetConfig.minSize,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
          const Positioned(bottom: p64, right: p16, child: ReportButton()),
          const Positioned(bottom: p128, right: p16, child: TrackButton()),
        ],
      ),
    );
  }
}
