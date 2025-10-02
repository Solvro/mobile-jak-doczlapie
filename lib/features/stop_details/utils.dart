String formatTime(DateTime timestamp) {
  return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
}
