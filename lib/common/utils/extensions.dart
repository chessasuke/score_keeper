import 'dart:core';

extension StringExtension on String {
  String capitalize() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
    return "";
  }

  String lastNChars(int n) {
    if (length < n) {
      return this;
    } else {
      return substring(length - n);
    }
  }
}

extension DateHelpers on DateTime {
  bool isTodayLocalTime() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }
}
