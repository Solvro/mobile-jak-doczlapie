import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";

class RouteChip extends StatelessWidget {
  const RouteChip({super.key, required this.text, this.color = RouteChipColor.red, this.style, this.leading});

  final String text;
  final RouteChipColor color;
  final TextStyle? style;
  final Widget? leading;

  Color get backgroundColor {
    return switch (color) {
      RouteChipColor.red => red2,
      RouteChipColor.orange => orange,
      RouteChipColor.grey => const Color(0xFF353339),
      RouteChipColor.green => const Color(0xFF5DAD41),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150, minWidth: 35),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: backgroundColor),
        borderRadius: BorderRadius.circular(6),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ?leading,
          Text(
            switch (text) {
              "POLREGIO" => "POLREG",
              final value => value,
            },
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            softWrap: false,
            style: style ?? context.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

enum RouteChipColor { red, orange, grey, green }
