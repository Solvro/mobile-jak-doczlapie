import "package:flutter/material.dart";

import "../data/line.dart";

class LineChip extends StatelessWidget {
  const LineChip({super.key, required this.line});

  final Line line;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(line.number));
  }
}
