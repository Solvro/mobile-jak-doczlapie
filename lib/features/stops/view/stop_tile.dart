import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "../../../app/router.dart";
import "../../../app/theme.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/cards/wide_tile_card.dart";
import "../data/stop.dart";

class StopTile extends StatelessWidget {
  const StopTile({super.key, required this.stop});

  final Stop stop;

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      leading: SizedBox.square(
        dimension: s71,
        child: Center(
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(text: "4\n", style: context.textTheme.headlineSmall?.white),
                TextSpan(text: "kierunki", style: context.textTheme.titleSmall?.white),
              ],
            ),
          ),
        ),
      ),
      child: ListTile(
        title: Text(stop.name),
        subtitle: Text("(${stop.coordinates.latitude}, ${stop.coordinates.longitude})"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.star, size: p24),
        ),
      ),
      onTap: () => context.router.push(StopDetailsRoute(id: stop.id.toString())),
    );
  }
}
