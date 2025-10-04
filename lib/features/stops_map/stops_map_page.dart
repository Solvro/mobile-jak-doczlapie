import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "data/stops_repository.dart";
import "hooks/use_coords.dart";
import "view/stops_map_view.dart";

@RoutePage()
class StopsMapPage extends HookConsumerWidget {
  const StopsMapPage({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressState = useState(address);
    final coords = useCoords(addressState.value);

    final stopsAsync = ref.watch(
      stopsRepositoryProvider(
        coords.data?.latitude.toString() != null
            ? (latitude: coords.data!.latitude.toString(), longitiude: coords.data!.longitude.toString())
            : null,
      ),
    );

    return StopsMapView(
      stops: stopsAsync.value,
      searchText: addressState.value,
      onSearchSubmitted: (value) => addressState.value = value,
    );
  }
}
