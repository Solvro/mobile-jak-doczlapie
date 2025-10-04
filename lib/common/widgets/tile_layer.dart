import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";

class AppTileLayer extends StatelessWidget {
  const AppTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: "pl.solvro.jak_doczlapie",
    );
  }
}
