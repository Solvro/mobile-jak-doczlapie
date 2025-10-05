import "package:flutter/material.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "route_list_shimmer_tile.dart";

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: p32, bottom: p8),
      itemCount: 5, // Show 5 shimmer tiles
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wyniki",
                style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: p8),
              const RouteListShimmerTile(),
            ],
          );
        }
        return const RouteListShimmerTile();
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: p8),
    );
  }
}
