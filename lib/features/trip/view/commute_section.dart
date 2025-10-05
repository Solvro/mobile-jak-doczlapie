import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/format_time.dart";
import "../../routes_list/view/route_chip.dart";
import "../../routes_map/data/route_response.dart";

class CommuteSection extends StatelessWidget {
  const CommuteSection({super.key, required this.segment, required this.isTrain});
  final Segment segment;
  final bool isTrain;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: p8,
          children: [
            const SizedBox(width: p4),
            RouteChip(
              color: isTrain ? RouteChipColor.orange : RouteChipColor.red,
              text: "${segment.departure.time.split(":").first}:${segment.departure.time.split(":")[1]}",
              style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
            Flexible(
              child: Text(
                segment.departure.name,
                style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: p4),
        Row(
          children: [
            if (isTrain)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                padding: const EdgeInsets.all(p8),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: orange),
                child: SvgPicture.asset(Assets.icons.train),
              )
            else
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                padding: const EdgeInsets.all(p4),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: red2),
                child: SvgPicture.asset(
                  Assets.icons.busVechicleIcon,
                  width: p20,
                  height: p20,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            const SizedBox(width: p8),
            Flexible(
              child: RouteChip(text: segment.name, color: isTrain ? RouteChipColor.orange : RouteChipColor.red),
            ),
            const SizedBox(width: p4),
            const Icon(Icons.east, color: Colors.white, size: 18),
            const SizedBox(width: p4),
            Flexible(
              child: Text(segment.destination, style: context.textTheme.titleSmall?.copyWith(color: Colors.white)),
            ),
            const Spacer(),
            Text(
              formatDuration(segment.travelTime),
              style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
          ],
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              const SizedBox(width: 32),
              Transform.translate(
                offset: const Offset(0, -6),
                child: VerticalDivider(color: !isTrain ? red2 : orange, thickness: 3, width: 3),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: ExpansionTile(
                  shape: const Border(),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: Text("3 przystanki", style: context.textTheme.titleSmall?.copyWith(color: Colors.white)),
                  children: const [
                    StopRoute(hour: "10:10", text: "Wrocław"),
                    SizedBox(height: p8),
                    StopRoute(hour: "10:11", text: "Kraków"),
                    SizedBox(height: p8),
                    StopRoute(hour: "10:12", text: "Warszawa"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 26),
            Transform.translate(
              offset: const Offset(0, -6),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEB6559),
                  border: Border.all(color: !isTrain ? red2 : orange, width: 4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StopRoute extends StatelessWidget {
  const StopRoute({super.key, required this.hour, required this.text});

  final String hour;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: p8,
      children: [
        RouteChip(text: hour),
        Text(text, style: context.textTheme.titleSmall?.copyWith(color: Colors.white)),
      ],
    );
  }
}
