import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/svg.dart";
import "package:latlong2/latlong.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../gen/assets.gen.dart";
import "../../routes_list/view/route_chip.dart";
import "../../routes_map/data/route_response.dart";
import "../../stops_map/hooks/use_coords.dart";

class WalkSection extends StatelessWidget {
  const WalkSection({super.key, required this.routeStop});

  final RouteStop routeStop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: p8,
          children: [
            RouteChip(
              text: "${routeStop.time.split(":").first}:${routeStop.time.split(":")[1]}",
              color: RouteChipColor.grey,
              style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
              leading: SvgPicture.asset(Assets.icons.point),
            ),
            AddresLabel(coordinates: routeStop.coordinates),
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              padding: const EdgeInsets.all(p8),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF353339)),
              child: SvgPicture.asset(Assets.icons.walk),
            ),
            const SizedBox(width: p16),
            Text("Idź ${routeStop.distance}m", style: context.textTheme.titleSmall?.copyWith(color: Colors.white)),
            const Spacer(),
            Text(
              "${((routeStop.distance ?? 1) / 1000 * 60 / 5).round()}min",
              style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
          ],
        ),
        const Row(children: [SizedBox(width: 28), DottedLine(dots: 4)]),
      ],
    );
  }
}

class AddresLabel extends HookWidget {
  const AddresLabel({super.key, this.coordinates});
  final LatLng? coordinates;
  @override
  Widget build(BuildContext context) {
    final address = useAddress(coordinates);
    return Text(address.data.toString(), style: context.textTheme.titleLarge?.copyWith(color: Colors.white));
  }
}

class DottedLine extends StatelessWidget {
  const DottedLine({super.key, required this.dots});

  final int dots;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 2,
      children: List.generate(
        dots,
        (index) => Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(color: white, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
