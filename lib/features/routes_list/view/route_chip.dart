import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";

class RouteChip extends StatelessWidget {
  const RouteChip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.zero,
      label: Text(text, style: context.textTheme.titleMedium),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: red2),
        borderRadius: BorderRadius.circular(6),
      ),
      backgroundColor: red2,
    );
  }
}
