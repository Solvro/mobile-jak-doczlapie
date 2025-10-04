import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";

class RouteChip extends StatelessWidget {
  const RouteChip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: red2),
        borderRadius: BorderRadius.circular(6),
        color: red2,
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
