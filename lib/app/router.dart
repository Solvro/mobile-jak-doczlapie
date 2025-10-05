import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../features/main_navigation/main_navigation_page.dart";
import "../features/main_navigation/routes_tab/routes_tab_page.dart";
import "../features/main_navigation/stops_tab/stops_tab_page.dart";
import "../features/report_schedule/report_schedule_page.dart";
import "../features/routes/routes_page.dart";
import "../features/routes_search_details/route_details_page.dart";
import "../features/stop_details/stop_details_page.dart";
import "../features/stops/stops_page.dart";
import "../features/stops_map/stops_map_page.dart";
import "../features/trip/trip_page.dart";

part "router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainNavigationRoute.page,
      initial: true,
      children: [
        AutoRoute(
          page: RoutesTabRoute.page,
          children: [
            AutoRoute(page: RoutesRoute.page, initial: true),
            AutoRoute(page: RouteDetailsRoute.page),
          ],
        ),
        AutoRoute(
          page: StopsTabRoute.page,
          children: [
            AutoRoute(page: StopsRoute.page, initial: true),
            AutoRoute(page: StopsMapRoute.page),
            AutoRoute(page: StopDetailsRoute.page),
            AutoRoute(page: TripRoute.page),
          ],
          initial: true,
        ),
      ],
    ),
    AutoRoute(page: ReportScheduleRoute.page),
  ];
}
