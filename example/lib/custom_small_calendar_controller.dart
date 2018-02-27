import 'dart:async';

import 'package:small_calendar/small_calendar.dart';

SmallCalendarController createSmallCalendarController() {
  Future<bool> isSelectedCallback(DateTime date) async {
    if (date.day == 10) {
      return true;
    }

    return false;
  }

  Future<bool> hasTick1Callback(DateTime date) async {
    if (date.day == 1 || date.day == 4 || date.day == 5) {
      return true;
    }

    return false;
  }

  Future<bool> hasTick2Callback(DateTime date) async {
    if (date.day == 2 || date.day == 4 || date.day == 5) {
      return true;
    }

    return false;
  }

  Future<bool> hasTick3Callback(DateTime date) async {
    if (date.day == 3 || date.day == 5) {
      return true;
    }

    return false;
  }

  return new SmallCalendarController(
    isSelectedCallback: isSelectedCallback,
    hasTick1Callback: hasTick1Callback,
    hasTick2Callback: hasTick2Callback,
    hasTick3Callback: hasTick3Callback,
  );
}
