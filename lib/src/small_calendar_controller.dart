import 'dart:async';

import 'package:small_calendar/src/callbacks.dart';

class SmallCalendarController {
  DateTimeCallback _onGoToListener;

  void addGoToListener(DateTimeCallback listener) {
    _onGoToListener = listener;
  }

  void removeGoToListener() {
    _onGoToListener = null;
  }

  void notifyGoToListener(DateTime dateToGoTo) {
    if (_onGoToListener != null) {
      _onGoToListener(dateToGoTo);
    }
  }

  // to override ---------------------------------------------------------------

  Future<bool> isToday(DateTime date) async {
    DateTime now = new DateTime.now();
    return (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day);
  }

  Future<bool> isSelected(DateTime date) async {
    return false;
  }

  Future<bool> hasTick1(DateTime date) async {
    return false;
  }

  Future<bool> hasTick2(DateTime date) async {
    return false;
  }

  Future<bool> hasTick3(DateTime date) async {
    return false;
  }

  void goTo(DateTime date) {
    notifyGoToListener(date);
  }

  void goToToday() {
    goTo(new DateTime.now());
  }
}
