import "package:flutter/material.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/cards/app_bar.dart";
import "../../../common/widgets/gradient_scaffold.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";

class RouteView extends StatelessWidget {
  const RouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        GradientScaffold(
          appBar: CommonAppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.route, size: 64, color: Colors.white),
                SizedBox(height: p16),
                Text(
                  "Trasa",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: p8),
                Text("Funkcja w trakcie rozwoju", style: TextStyle(color: Colors.white70, fontSize: 16)),
              ],
            ),
          ),
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: ClippedBottomNavBar(isSmall: true)),
      ],
    );
  }
}
