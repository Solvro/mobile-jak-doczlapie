import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../common/widgets/gradient_scaffold.dart";

@RoutePage()
class ReportIncidentsPage extends StatelessWidget {
  const ReportIncidentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientScaffold(body: Center(child: Text("Report Incidents")));
  }
}
