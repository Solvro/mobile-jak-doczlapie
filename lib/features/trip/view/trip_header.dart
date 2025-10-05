import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";

import "../../../common/widgets/cards/blur_card.dart";
import "../../../gen/assets.gen.dart";
import "../data/trip_repository.dart";

class TripHeader extends StatelessWidget {
  const TripHeader({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BlurCard(
          borderRadius: r31,
          child: Padding(
            padding: EdgeInsets.all(p16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HourTitle(hour: "10:10", text: "Wrocław"),
                SizedBox(width: 2, height: 70, child: VerticalDivider(color: greyBorder)),
                HourTitle(hour: "11:11", text: "Warszawa"),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: const Offset(0, 90),
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
      children: [
        Text(hour, style: context.textTheme.headlineLarge?.copyWith(color: Colors.white)),
        Text(
          text,
          style: context.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
