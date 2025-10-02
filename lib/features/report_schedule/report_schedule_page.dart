import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "view/report_schedule_view.dart";

@RoutePage()
class ReportSchedulePage extends StatelessWidget {
  const ReportSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReportScheduleView();
  }
}
