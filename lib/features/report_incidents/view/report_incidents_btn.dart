import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/tokens.dart";
import "../../../gen/assets.gen.dart";

class ReportIncidentsBtn extends StatelessWidget {
  const ReportIncidentsBtn({super.key, required this.routeId, required this.runId});
  final String routeId;
  final int runId;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await context.router.push(ReportIncidentsRoute(routeId: routeId, runId: runId));
        },
        borderRadius: BorderRadius.circular(71),
        child: SizedBox(width: p56, height: p56, child: Assets.yellowButton.image()),
      ),
    );
  }
}
