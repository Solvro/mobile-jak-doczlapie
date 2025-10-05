import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../gen/assets.gen.dart";
import "../../routes_list/view/route_chip.dart";

class WalkSection extends StatelessWidget {
  const WalkSection({
    super.key,
    required this.address,
    required this.time,
    required this.distance,
    required this.duration,
  });

  final String address;
  final String time;
  final int distance;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: p8,
          children: [
            RouteChip(
              text: time,
              color: RouteChipColor.grey,
              style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
              leading: SvgPicture.asset(Assets.icons.point),
            ),
            Text(address, style: context.textTheme.titleLarge?.copyWith(color: Colors.white)),
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
            Text("Idź ${distance}m", style: context.textTheme.titleSmall?.copyWith(color: Colors.white)),
            const Spacer(),
            Text("${duration}m", style: context.textTheme.titleSmall?.copyWith(color: Colors.white)),
          ],
        ),
        const Row(children: [SizedBox(width: 28), DottedLine(dots: 4)]),
      ],
    );
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
