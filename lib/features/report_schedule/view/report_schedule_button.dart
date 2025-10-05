import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../bottom_nav/view/bean_button.dart";

class ReportScheduleButton extends StatelessWidget {
  const ReportScheduleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BeanButton(
      icon: const Icon(Icons.camera_alt, color: Colors.white),
      onTap: () => context.router.push(const ReportScheduleRoute()),
    );
  }
}
