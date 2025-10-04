import "package:intl/intl.dart";

extension DateTimePolishFormat on DateTime {
  /// Zwraca np. "Pn. 04 paź. 11:38"
  String toPolishShort() {
    return DateFormat("E. dd MMM HH:mm", "pl_PL").format(this);
  }

  /// Zwraca pełną datę np. "poniedziałek, 4 października 2025, 11:38"
  String toPolishLong() {
    return DateFormat("EEEE, d MMMM y, HH:mm", "pl_PL").format(this);
  }

  /// Tylko data np. "04.10.2025"
  String toPolishDate() {
    return DateFormat("dd.MM.y", "pl_PL").format(this);
  }

  /// Tylko godzina np. "11:38"
  String toPolishTime() {
    return DateFormat("HH:mm", "pl_PL").format(this);
  }
}
