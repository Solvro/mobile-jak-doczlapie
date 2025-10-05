import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/route_list_app_bar.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../../routes_search_details/data/route_response.dart";
import "route_list_tile.dart";

class RouteListView extends StatelessWidget {
  const RouteListView({super.key, this.routes});
  final List<RouteResponse>? routes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: const RouteListAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: p16),
            child: ListView.separated(
              padding: const EdgeInsets.only(top: p32, bottom: p8),
              itemCount: 10,
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
                      RouteListTile(isPunctual: index.isOdd),
                    ],
                  );
                }
                return RouteListTile(isPunctual: index.isOdd);
              },
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: p8),
            ),
          ),
          const Align(alignment: Alignment.bottomCenter, child: FadeBottomNavBar()),
        ],
      ),
    );
  }
}
