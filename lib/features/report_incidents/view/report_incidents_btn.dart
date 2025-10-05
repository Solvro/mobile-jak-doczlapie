import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/router.dart";
import "../../../app/tokens.dart";

class ReportIncidentsBtn extends StatelessWidget {
  const ReportIncidentsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await context.router.push(const ReportIncidentsRoute());
        },
        borderRadius: BorderRadius.circular(71),
        child: Container(
          width: p56,
          height: p56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(71),
            border: Border.all(color: const Color(0xFFFFB159)),
            gradient: const LinearGradient(
              stops: [0.0316, 1.3747],
              colors: [
                Color(0x66FB4716), // rgba(251, 71, 22, 0.40)
                Color(0x66FF6A00), // rgba(255, 106, 0, 0.40)
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x00AFAFAF), // rgba(175, 175, 175, 0.00)
                offset: Offset(24, -30),
                blurRadius: 40,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(71),
            child: const Center(child: Icon(Icons.warning, color: Color(0xFFE5A45E), size: 24)),
          ),
        ),
      ),
    );
  }
}
