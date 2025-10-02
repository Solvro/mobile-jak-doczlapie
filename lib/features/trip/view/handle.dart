import "package:flutter/material.dart";

import "../../../app/tokens.dart";

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double size;
  const PersistentHeaderDelegate({required this.child, required this.size});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class Handle extends StatelessWidget {
  const Handle();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: p8),
      width: p32,
      height: p4,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(r4)),
    );
  }
}
