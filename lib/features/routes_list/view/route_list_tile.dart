import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../utils/format_time.dart";
import "../../routes_map/data/route_response.dart";
import "../../routes_map/view/segments_divider.dart";
import "route_chip.dart";

class RouteListTile extends StatelessWidget {
  const RouteListTile({super.key, this.isPunctual = false, required this.route});
  final bool isPunctual;
  final RouteResponse route;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: isPunctual ? green : const Color(0xFF777777), width: 2),
        color: darkGrey,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await context.router.push(RouteTripRoute(route: route));
          },
          borderRadius: BorderRadius.circular(29),
          splashColor: Colors.white.withValues(alpha: 0.1),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.all(p16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${route.departure.time.split(":").first}:${route.departure.time.split(":")[1]}",
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        ),
                        if (isPunctual) Text("Punktualnie", style: context.textTheme.bodySmall?.copyWith(color: green)),
                      ],
                    ),
                    Column(
                      spacing: p4,
                      children: [
                        Text(
                          route.transfers == 0 ? "Bez przesiadek" : "${route.transfers} przesiadki",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2, width: 100, child: SegmentsDivider(route: route)),
                        Text(
                          formatDuration(route.travelTime),
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.white, letterSpacing: -1),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${route.arrival.time.split(":").first}:${route.arrival.time.split(":")[1]}",
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(color: Color(0xFF777777)),
                Row(children: [RouteChip(text: route.routes.first.operator)]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
