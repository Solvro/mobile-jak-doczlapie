import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top-left
    path.moveTo(0, 0);

    // Go to top-right
    path.lineTo(size.width, 0);

    // Go to bottom-right corner
    path.lineTo(size.width, size.height - 30);

    // Create the curved bottom edge (arc going upward) across the full width
    path.quadraticBezierTo(
      size.width / 2, // Control point x (center)
      size.height - 50, // Control point y (above the bottom - creates upward curve)
      0, // End point x (left side)
      size.height - 30, // End point y
    );

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
