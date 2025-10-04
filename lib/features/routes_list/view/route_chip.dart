import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";

enum RouteChipColor { red, orange }

class RouteChip extends StatelessWidget {
  const RouteChip({super.key, required this.text, this.color = RouteChipColor.red});

  final String text;
  final RouteChipColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150, minWidth: 35),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color == RouteChipColor.red ? red2 : orange),
        borderRadius: BorderRadius.circular(6),
        color: color == RouteChipColor.red ? red2 : orange,
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center, // środek wewnątrz maxWidth
        softWrap: false,
        style: context.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
