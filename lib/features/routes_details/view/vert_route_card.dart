import "package:flutter/material.dart" hide Route;
import "package:flutter_svg/svg.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../routes_list/view/route_chip.dart";
import "route_detail_view.dart" show Route;
import "../../../gen/assets.gen.dart";
import "../../../common/widgets/cards/vert_card.dart";

class VertRouteCard extends StatelessWidget {
  const VertRouteCard({super.key, required this.route, this.isActive = false, this.onTap});

  final Route route;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isActive ? 0 : VertCard.heightActive - VertCard.height),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(r31),
          splashColor: Colors.white.withValues(alpha: 0.2),
          highlightColor: Colors.white.withValues(alpha: 0.1),
          child: Container(
            width: 167,
            height: isActive ? VertCard.heightActive : VertCard.height,
            decoration: BoxDecoration(
              color: isActive ? blueColorNew : const Color(0xFF252328),
              borderRadius: BorderRadius.circular(r31),
            ),
            child: Padding(
              padding: const EdgeInsets.all(p8),
              child: Column(
                children: [
                  // White top section
                  Container(
                    height: 62,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFF252328) : blueColorNew,
                      borderRadius: const BorderRadius.all(Radius.circular(r25)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Odjazd", style: context.textTheme.bodySmall?.bold.withColor(Colors.white)),
                              Text(route.startTime, style: context.textTheme.titleLarge?.bold.withColor(Colors.white)),
                            ],
                          ),
                          Container(width: 1, height: 38, color: const Color(0xFF777777)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Przyjazd", style: context.textTheme.bodySmall?.bold.withColor(Colors.white)),
                              Text(route.endTime, style: context.textTheme.titleLarge?.bold.withColor(Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: p12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            runSpacing: p4,
                            spacing: p8,
                            children: route.segments.map((segment) {
                              final isTrain = segment.lineNumber.contains("IC");
                              return RouteChip(
                                text: segment.lineNumber,
                                color: isTrain ? RouteChipColor.orange : RouteChipColor.red,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SegmentsDivider(route: route),
                  const SizedBox(height: p8),
                  Row(
                    spacing: p8,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? Colors.white : blueColorNew,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(p8),
                          child: SvgPicture.asset(
                            Assets.icons.busVechicleIcon,
                            height: p20,
                            colorFilter: isActive
                                ? const ColorFilter.mode(Colors.black, BlendMode.srcIn)
                                : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            route.segments.length - 1 == 0
                                ? "Bez przesiadek"
                                : "${route.segments.length - 1} przesiadki",
                            style: context.textTheme.bodySmall?.bold.withColor(Colors.white),
                          ),
                          Text(route.totalTime, style: context.textTheme.bodySmall?.withColor(Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SegmentsDivider extends StatelessWidget {
  const SegmentsDivider({super.key, required this.route});

  final Route route;

  @override
  Widget build(BuildContext context) {
    if (route.segments.isEmpty) {
      return const SizedBox.shrink();
    }

    // Calculate total duration to determine segment proportions
    final totalDuration = route.segments.fold<Duration>(Duration.zero, (total, segment) => total + segment.duration);

    return SizedBox(
      height: 2,
      width: double.infinity,
      child: Row(
        spacing: 1,
        children: route.segments.map((segment) {
          final isTrain = segment.lineNumber.contains("IC");
          final segmentDuration = segment.duration;
          final proportion = totalDuration.inMilliseconds > 0
              ? segmentDuration.inMilliseconds / totalDuration.inMilliseconds
              : 1.0 / route.segments.length;

          return Expanded(
            flex: (proportion * 100).round(),
            child: Container(
              height: 4,
              decoration: BoxDecoration(color: isTrain ? orange : red2, borderRadius: BorderRadius.circular(2)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
