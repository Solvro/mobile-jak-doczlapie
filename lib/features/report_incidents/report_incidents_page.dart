import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../common/widgets/app_bars/simple_logo_app_bar.dart";
import "../../common/widgets/gradient_scaffold.dart";

@RoutePage()
class ReportIncidentsPage extends StatelessWidget {
  const ReportIncidentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Column(children: [SimpleLogoAppBar(), const Text("Zgłoś zdarzenie na aktualnej trasie!")]),
    );
  }
}
