import "package:flutter_hooks/flutter_hooks.dart";

import "../../stops_map/data/schedule.dart";

String useFirstDepartureTime(List<Schedule> schedules, String direction) {
  return useMemoized(() {
    // TODO(simon-the-shark): fix time sorting
    final filteredSchedules = schedules.where((schedule) => schedule.destination == direction).toList();
    filteredSchedules.sort((a, b) => a.time.compareTo(b.time));
    return filteredSchedules.first.time;
  }, [schedules]);
}
