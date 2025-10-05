String formatDuration(int minutes) {
  final duration = Duration(minutes: minutes.abs());
  final hours = duration.inHours;
  final mins = duration.inMinutes.remainder(60);

  if (hours > 0) {
    if (mins > 0) {
      return "${hours}h ${mins}min";
    } else {
      return "${hours}h";
    }
  } else {
    return "${mins}min";
  }
}
