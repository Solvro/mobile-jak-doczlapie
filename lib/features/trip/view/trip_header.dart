import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";

import "../../../common/widgets/cards/blur_card.dart";
import "../../../gen/assets.gen.dart";
import "../../routes_map/data/route_response.dart";

class TripHeader extends StatelessWidget {
  const TripHeader({super.key, required this.route});

  final RouteResponse route;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 120,
          child: BlurCard(
            borderRadius: r31,
            child: Padding(
              padding: const EdgeInsets.all(p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: HourTitle(
                      hour: "${route.departure.time.split(":").first}:${route.departure.time.split(":")[1]}",
                      text: route.departure.name,
                    ),
                  ),
                  const SizedBox(width: 2, height: 70, child: VerticalDivider(color: greyBorder)),
                  Flexible(
                    child: HourTitle(
                      hour: "${route.arrival.time.split(":").first}:${route.arrival.time.split(":")[1]}",
                      text: route.arrival.name,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: const Offset(0, 107),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: p8, vertical: p4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 84, 143, 63),
                border: Border.all(color: const Color(0xFF7ECA63)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.icons.time),
                  const SizedBox(width: p4),
                  Text("Punktualnie", style: context.textTheme.titleSmall?.copyWith(color: const Color(0xFF7ECA63))),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HourTitle extends StatelessWidget {
  const HourTitle({super.key, required this.hour, required this.text});

  final String hour;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(hour, style: context.textTheme.headlineLarge?.copyWith(color: Colors.white)),
        Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
