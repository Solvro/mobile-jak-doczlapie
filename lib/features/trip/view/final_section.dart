import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../routes_list/view/route_chip.dart";

class FinalSection extends StatelessWidget {
  const FinalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: p8,
      children: [
        const SizedBox(width: p4),
        RouteChip(
          text: "10:21",
          style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
          color: RouteChipColor.green,
        ),
        Text("ul. Piątka 1", style: context.textTheme.titleLarge?.copyWith(color: Colors.white)),
      ],
    );
  }
}
