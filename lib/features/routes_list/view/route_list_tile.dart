import "package:flutter/material.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "route_chip.dart";

class RouteListTile extends StatelessWidget {
  const RouteListTile({super.key, this.isPunctual = false});
  final bool isPunctual;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        border: Border.all(color: isPunctual ? green : const Color(0xFF777777), width: 2),
        color: darkGrey,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "11:42",
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                  if (isPunctual) Text("Punktualnie", style: context.textTheme.bodySmall?.copyWith(color: green)),
                ],
              ),
              Column(
                spacing: p4,
                children: [
                  Text(
                    "1 przesiadka",
                    style: context.textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 2,
                    width: 100,
                    child: LinearProgressIndicator(color: red2, value: 0.5, backgroundColor: orange),
                  ),
                  Text(
                    "1h 12 min",
                    style: context.textTheme.bodySmall?.copyWith(color: Colors.white, letterSpacing: -1),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "11:42",
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Color(0xFF777777)),
          const Row(children: [RouteChip(text: "ICC")]),
        ],
      ),
    );
  }
}
