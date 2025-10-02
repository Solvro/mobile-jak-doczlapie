import "package:flutter/material.dart";

class LineChip extends StatelessWidget {
  const LineChip({super.key, required this.lineNumber});

  final String lineNumber;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(lineNumber));
  }
}
