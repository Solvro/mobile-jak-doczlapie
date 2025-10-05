import "package:flutter/material.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/route_list_app_bar.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";
import "../../routes_search_details/data/route_response.dart";
import "routes_list_widget.dart";
import "shimmer_loading_widget.dart";

class RouteListView extends StatelessWidget {
  const RouteListView({super.key, this.routes, required this.fromAddress, required this.toAddress});
  final List<RouteResponse>? routes;

  final ValueNotifier<String> fromAddress;
  final ValueNotifier<String> toAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: RouteListAppBar(fromAddress: fromAddress, toAddress: toAddress),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: p16),
            child: routes == null ? const ShimmerLoadingWidget() : RoutesListWidget(routes: routes!),
          ),
          const Align(alignment: Alignment.bottomCenter, child: FadeBottomNavBar()),
        ],
      ),
    );
  }
}
