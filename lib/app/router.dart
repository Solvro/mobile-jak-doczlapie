import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../features/home/home_page.dart";
import "../features/stop_details/stop_details_page.dart";

part "router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: StopDetailsRoute.page),
  ];
}
