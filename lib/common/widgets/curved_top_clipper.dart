import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from bottom-left
    path.moveTo(0, size.height);

    // Go to bottom-right
    path.lineTo(size.width, size.height);

    // Go to top-right corner
    path.lineTo(size.width, 25);

    // Create the curved top edge (arc going downward) across the full width
    path.quadraticBezierTo(
      size.width / 2, // Control point x (center)
      65, // Control point y (middle ground - balanced curve)
      0, // End point x (left side)
      25, // End point y
    );

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
